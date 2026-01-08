//
// RenderingContext.swift
// Raptor
// https://raptor.build
//

import Foundation

/// Holds all per-page rendering state and environment.
/// Stored as a task-local reference so markup views can access it.
package struct RenderingContext: Sendable {
    /// Task-local accessor for the current page-rendering context.
    @TaskLocal package static var current: Self?

    /// The static site configuration.
    package let site: SiteContext

    /// The locale used for this render.
    package let locale: Locale

    /// Posts available for lookup during rendering.
    package var posts: [Post] = []

    /// Source root directory for the entire site.
    package let rootDirectory: URL

    /// Output directory for generated pages.
    package let buildDirectory: URL

    /// The site’s default locale.
    let defaultLocale: Locale?

    /// Asset folder root.
    let assetsDirectory: URL

    /// Includes folder root.
    let includesDirectory: URL

    /// Environment values for all HTML components.
    package var environment: EnvironmentValues

    /// The currently active post (for PostPage renders).
    var activePost: Post = .init()

    /// The active category during a category render.
    var activeCategory: any Category = EmptyCategory()

    /// Current HTTP error for error page rendering.
    var httpError: HTTPError = EmptyHTTPError()

    /// Search results populated during search pages.
    var searchResults: SearchResultCollection = .init()

    /// Raw content of a page before layout wrapping.
    var pageMarkup: String = ""

    /// All known categories aggregated from posts.
    var categories: [any Category] {
        let names = Set(posts
            .compactMap(\.tags)
            .flatMap { $0 }
            .map(\.name)
        ).sorted()

        let tagCats = names.map { TagCategory(name: $0, posts: content(tagged: $0)) }
        return tagCats + [AllTagsCategory(posts: content(tagged: nil))]
    }

    package init(
        site: SiteContext,
        locale: Locale,
        posts: [Post],
        rootDirectory: URL,
        buildDirectory: URL,
        environment: EnvironmentValues = .init()
    ) {
        self.site = site
        self.locale = locale
        self.rootDirectory = rootDirectory
        self.buildDirectory = buildDirectory
        self.environment = environment
        self.assetsDirectory = rootDirectory.appending(path: "Assets")
        self.includesDirectory = rootDirectory.appending(path: "Includes")
        self.defaultLocale = site.locales.first
        self.posts = posts.map {
            var post = $0
            post.path = localizedPath(for: post.rawPath)
            return post
        }
    }

    package init(
        site: SiteContext,
        posts: [Post],
        rootDirectory: URL,
        buildDirectory: URL,
        environment: EnvironmentValues = .init()
    ) {
        self.site = site
        self.locale = site.locales.first ?? .automatic
        self.rootDirectory = rootDirectory
        self.buildDirectory = buildDirectory
        self.environment = environment
        self.assetsDirectory = rootDirectory.appending(path: "Assets")
        self.includesDirectory = rootDirectory.appending(path: "Includes")
        self.defaultLocale = site.locales.first
        self.posts = posts.map {
            var post = $0
            post.path = localizedPath(for: post.rawPath)
            return post
        }
    }

    /// Uses the site's default layout when `.layout` is DefaultLayout.
    package func resolvedLayout(for layout: any Layout, in site: any Site) -> any Layout {
        type(of: layout) == DefaultLayout.self ? site.layout : layout
    }

    /// Renders any static page using the provided layout.
    /// - Returns: A fully rendered `RenderedPage`.
    package func render(
        _ page: some Page,
        using layout: any Layout
    ) -> RenderedPage {
        render(
            page,
            layout: layout,
            rootPath: page.path,
            pagePath: page.path
        )
    }

    /// Renders the home page.
    package func render(
        homePage: any Page,
        using layout: any Layout
    ) -> RenderedPage {
        render(
            homePage,
            layout: layout,
            rootPath: "/",
            pagePath: "",
            priority: 1
        )
    }

    /// Core shared page rendering logic.
    private func render(
        _ page: any Page,
        layout: any Layout,
        rootPath: String,
        pagePath: String,
        priority: Double? = 0.9,
        filename: String = "index"
    ) -> RenderedPage {
        let path = pagePath
        let localizedURL = localizedURL(for: path)

        // Create metadata
        let metadata = PageMetadata(
            title: page.title,
            description: page.description,
            url: localizedURL,
            image: page.image
        )

        // Derive a new renderer snapshot with updated environment
        var updated = self
        updated.environment = EnvironmentValues(
            rootDirectory: rootDirectory,
            site: site,
            locale: locale,
            allContent: posts,
            pageMetadata: metadata
        )

        updated.pageMarkup = RenderingContext.$current.withValue(updated) {
            page.body.markupString()
        }

        // Render layout wrapping
        let outputHTML = RenderingContext.$current.withValue(updated) {
            layout.body.markupString()
        }

        // Optional search metadata
        var searchMetadata: SearchMetadata?
        if site.isSearchEnabled, !page.description.isEmpty {
            searchMetadata = SearchMetadata(
                id: localizedURL.path(),
                title: metadata.title,
                description: metadata.description
            )
        }

        return RenderedPage(
            html: outputHTML,
            prettify: site.prettifyHTML,
            path: buildDirectory.appending(path: path),
            priority: priority,
            filename: filename,
            searchMetadata: searchMetadata
        )
    }
}
