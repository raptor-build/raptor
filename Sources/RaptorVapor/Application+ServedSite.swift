//
// Application+Raptor.swift
// RaptorVapor
// https://raptor.build
// See LICENSE for license information.
//

import Vapor
import Raptor

extension Application {
    /// Internal storage used to keep the site's runtime data
    /// (the parsed posts and the source directory).
    var site: ResolvedSite {
        get { storage[ResolvedSite.Key.self] ?? .empty }
        set { storage[ResolvedSite.Key.self] = newValue }
    }

    /// Bootstraps Raptor for server-side rendering inside Vapor.
    ///
    /// This parses all Markdown content, prepares the site (running
    /// user-defined async setup), and stores the resulting served site
    /// in Vapor’s application storage where routes can access it.
    ///
    /// - Parameter site: The user’s site type.
    public func mount(_ site: some Site, from file: StaticString = #filePath) async throws {
        var mutableSite = site
        let servedSite = try await mutableSite.serve(from: file)
        self.site = servedSite

        try await generateRuntimeAssets(for: site)
        configureRaptorStaticFileServing() // auto-mount Raptor’s .build assets
        registerRaptorRoutes()
        middleware.use(RaptorErrorMiddleware())
    }
}

extension Application {
    /// Generates the assets required for **server-side rendering**.
    ///
    /// This calls a subset of what the static publisher normally does:
    /// - CSS generation
    /// - JS copying
    /// - Fonts copying
    /// - User assets
    /// - Search index (if enabled)
    ///
    /// Output directory:
    ///
    ///     <package>/.raptor-runtime/
    ///
    private func generateRuntimeAssets(for site: some Site) async throws {
        // swiftlint:disable:previous function_body_length
        let posts = self.site.posts
        let rootDirectory = self.site.rootDirectory

        // Runtime build root: <package>/.build/raptor
        let build = rootDirectory.appending(path: ".build/raptor")

        // Clean + recreate build directory
        try? FileManager.default.removeItem(at: build)
        try FileManager.default.createDirectory(at: build, withIntermediateDirectories: true)

        var buildContext = self.site.buildContext

        for locale in site.locales {
            let isDefault = locale == site.locales.first
            let localizedRoot = isDefault
                ? build
                : build.appending(path: locale.asRFC5646.lowercased())

            if !isDefault {
                try FileManager.default.createDirectory(at: localizedRoot, withIntermediateDirectories: true)
            }

            let localizedPosts = posts.filter { $0.locale == locale }

            let renderer = RenderingContext(
                site: site.context,
                locale: locale,
                posts: localizedPosts,
                rootDirectory: rootDirectory,
                buildDirectory: localizedRoot
            )

            let (renderedPages, context) = RequestContext.$current.withValue(.empty) {
                renderer.render(site)
            }

            buildContext = buildContext.merging(context)

            var searchEntries: [SearchMetadata] = []
            var siteMap: [Location] = []

            for page in renderedPages {
                if let metadata = page.searchMetadata { searchEntries.append(metadata) }

                let relative = page.path.relative(to: localizedRoot)

                try FileManager.default.createDirectory(
                    at: page.path,
                    withIntermediateDirectories: true
                )

                let output = page.path.appending(path: page.filename + ".html")
                try page.html.write(to: output, atomically: true, encoding: .utf8)

                if let priority = page.priority {
                    siteMap.append(.init(path: relative, priority: priority))
                }
            }

            let localizedGenerator = LocalizedSiteResourceGenerator(
                site: site.context,
                buildDirectory: localizedRoot
            )

            localizedGenerator.generateFeed(locale: locale, content: localizedPosts)
            localizedGenerator.generateSiteMap(locations: siteMap, locale: locale)

            if site.isSearchEnabled {
                localizedGenerator.generateSearchIndex(from: searchEntries, for: locale)
            }
        }

        let generator = SiteResourceGenerator(
            rootDirectory: rootDirectory,
            buildDirectory: build,
            buildContext: buildContext,
            siteContext: site.context
        )

        let (_, resourceContext) = BuildContext.withNewContext {
            generator.copyResources()
            generator.generateSitemapIndex()
            generator.generateRobots()
        }

        buildContext = buildContext.merging(resourceContext)

        let (_, cssContext) = await BuildContext.withNewContext {
            let styleGenerator = StyleGenerator(
                themes: site.themes,
                rawStyles: buildContext.styles,
                scopedStyles: buildContext.scopedStyles)

            async let styleCSS = styleGenerator.generate()

            let cssGenerator = CSSGenerator(site: site, buildContext: buildContext)
            async let siteCSS = cssGenerator.generateSiteCSS()
            let prismCSS = cssGenerator.generatePrismThemeCSS()

            generator.write(prismCSS, to: "prism-themes.css")
            generator.write(await siteCSS, to: "raptor-core.css")
            generator.write(await styleCSS, to: "raptor-core.css")
        }

        buildContext = buildContext.merging(cssContext)
    }

    /// Makes Vapor serve **Raptor’s built CSS/JS/fonts** from:
    ///
    ///     .build/raptor/
    ///
    /// Files become publicly available at:
    ///
    ///     /css/*
    ///     /js/*
    ///     /fonts/*
    ///     /search-index.json
    ///
    private func configureRaptorStaticFileServing() {
        let assetRoot = site.rootDirectory
            .appending(path: ".build/raptor")

        if !FileManager.default.fileExists(atPath: assetRoot.path) {
            return
        }

        // Serve everything inside .build/raptor as static files
        middleware.use(FileMiddleware(publicDirectory: assetRoot.path))
    }
}
