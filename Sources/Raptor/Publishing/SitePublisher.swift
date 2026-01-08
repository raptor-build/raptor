//
// PublishingContext.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

import Foundation
import OrderedCollections
import SwiftSoup

/// Site publishers manage the entire flow of publishing, through all
/// elements. This allows any part of the site to reference content, add
/// build warnings, and more.
struct SitePublisher {
    /// The site that is currently being built.
    var site: any Site

    /// All the Markdown content this user has inside their Posts folder.
    var allPosts: [Post]

    /// The root directory for the user's website package.
    var rootDirectory: URL

    /// The directory containing their final, built website.
    var buildDirectory: URL

    /// Aggregated build-wide metadata and diagnostics collected during page rendering.
    var buildContext: BuildContext

    /// Creates a new site publisher for a specific site, providing the path to
    /// one of the user's file. This then navigates upwards to find the root directory.
    /// - Parameters:
    ///   - site: The site we're currently publishing.
    ///   - file: One file from the user's package.
    ///   - buildDirectoryPath: The path where the artifacts are generated.
    ///   The default is "Build".
    init(
        for site: any Site,
        with content: [Post],
        buildContext: BuildContext,
        rootDirectory: URL,
        buildDirectory: URL
    ) throws {
        self.site = site
        self.allPosts = content
        self.rootDirectory = rootDirectory
        self.buildDirectory = buildDirectory
        self.buildContext = buildContext
    }

    /// Performs all steps required to publish the entire site, including all configured locales.
    ///
    /// This method clears the build directory, iterates through each locale,
    /// generates localized content, and produces all required site resources
    /// such as the search index, robots.txt, and CSS stylesheets.
    ///
    /// - Throws: `PublishingError` if any step fails.
    mutating func publish() async throws {
        clearBuildFolder()

        for locale in OrderedSet(site.locales) {
            publish(locale)
        }

        let resourceGenerator = SiteResourceGenerator(
            rootDirectory: rootDirectory,
            buildDirectory: buildDirectory,
            buildContext: buildContext,
            siteContext: site.context)

        let (_, resourceContext) = BuildContext.withNewContext {
            resourceGenerator.copyResources()
            resourceGenerator.generateSitemapIndex()
            resourceGenerator.generateRobots()
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

            resourceGenerator.write(prismCSS, to: "prism-themes.css")
            resourceGenerator.write(await siteCSS, to: "raptor-core.css")
            resourceGenerator.write(await styleCSS, to: "raptor-core.css")
        }

        buildContext = buildContext.merging(cssContext)
        reportDiagnostics()
    }

    /// Writes a single string of data to a URL.
    /// - Parameters:
    ///   - string: The string to write.
    ///   - directory: The directory to write to. This has "<filename>.html"
    ///   appended to it, so users are directed to the correct page immediately.
    ///   - priority: A priority value to control how important this content
    ///   is for the sitemap.
    ///   - filename: The filename to use. Defaults to "index". Do not include the MIME type.
    mutating private func write(_ string: String, to directory: URL, priority: Double?, filename: String = "index") {
        do {
            try FileManager.default.createDirectory(at: directory, withIntermediateDirectories: true)
        } catch {
            buildContext.errors.append(.failedToCreateBuildDirectory(directory))
        }

        let outputURL = directory.appending(path: filename.appending(".html"))

        do {
            try string.write(to: outputURL, atomically: true, encoding: .utf8)
        } catch {
            buildContext.errors.append(.failedToCreateBuildFile(outputURL))
        }
    }

    /// Generates the localized version of the site for the given locale.
    /// - Parameter locale: The locale currently being processed (e.g. "en-US", "it").
    mutating private func publish(_ locale: Locale) {
        let localizedBuildDirectory = localizedBuildDirectory(for: locale)
        let localizedContent: [Post] = allPosts.filter { $0.locale == locale }

        let renderer = RenderingContext(
            site: site.context,
            locale: locale,
            posts: localizedContent,
            rootDirectory: rootDirectory,
            buildDirectory: localizedBuildDirectory
        )

        let (renderedPages, pageBuildContext) = renderer.render(site)

        buildContext = buildContext.merging(pageBuildContext)

        var searchMetadata = [SearchMetadata]()

        let resourceGenerator = LocalizedSiteResourceGenerator(
            site: site.context,
            buildDirectory: localizedBuildDirectory)

        var siteMap = [Location]()

        for page in renderedPages {
            page.searchMetadata.map { searchMetadata.append($0) }
            write(page.html, to: page.path, priority: page.priority, filename: page.filename)

            guard let priority = page.priority else { continue }
            let relativePath = page.path.relative(to: localizedBuildDirectory)
            siteMap.append(.init(path: relativePath, priority: priority))
        }

        if site.isSearchEnabled {
            resourceGenerator.generateSearchIndex(from: searchMetadata, for: locale)
        }

        resourceGenerator.generateFeed(locale: locale, content: localizedContent)
        resourceGenerator.generateSiteMap(locations: siteMap, locale: locale)
    }

    /// Resolves the correct build directory for a given locale.
    /// - Parameter locale: The locale being published.
    /// - Returns: The resolved output directory for this locale.
    private func localizedBuildDirectory(for locale: Locale) -> URL {
        let defaultLocale = site.locales.first ?? locale
        let identifier = locale.asRFC5646.lowercased()

        // If no per-locale folder should be used, return the root build directory.
        guard locale != defaultLocale else {
            return buildDirectory
        }

        let path = buildDirectory.appending(path: identifier)

        do {
            try FileManager.default.createDirectory(
                at: path,
                withIntermediateDirectories: true
            )
        } catch {
            print("Failed to create directory for \(identifier): \(error)")
        }

        return path
    }

    /// Removes all content from the Build folder, so we're okay to recreate it.
    private func clearBuildFolder() {
        // Apple's docs for fileExists() recommend _not_ to check
        // existence and then make change to the file system, so we
        // just try our best and silently fail.
        try? FileManager.default.removeItem(at: buildDirectory)

        do {
            try FileManager.default.createDirectory(at: buildDirectory, withIntermediateDirectories: true)
        } catch {
            fatalError(BuildError.failedToCreateBuildDirectory(buildDirectory).description)
        }
    }

    /// Reports any warnings or errors that occurred during the publishing process.
    private func reportDiagnostics() {
        let warnings = buildContext.warnings
        let errors = buildContext.errors
        if !warnings.isEmpty || !errors.isEmpty {
            print("📘 Publish completed with exceptions:")
            print(errors.map { "\t📕 \($0.errorDescription!)" }.joined(separator: "\n"))
            print(warnings.map { "\t📙 \($0)" }.joined(separator: "\n"))
        } else {
            print("📗 Publish completed!")
        }
    }
}
