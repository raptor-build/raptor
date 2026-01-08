//
// RenderingContext+Rendering.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

package extension RenderingContext {
    /// Renders a blog post.
    func render(
        _ post: Post,
        using postPage: any PostPage,
        with layout: any Layout
    ) -> RenderedPage {
        let localizedURL = localizedURL(for: post.rawPath)

        let metadata = PageMetadata(
            title: post.title,
            description: post.description,
            url: localizedURL,
            image: post.image.flatMap(URL.init(string:))
        )

        var updated = self
        updated.activePost = post
        updated.environment = EnvironmentValues(
            rootDirectory: rootDirectory,
            site: site,
            locale: locale,
            allContent: posts,
            pageMetadata: metadata
        )

        let (outputHTML, _) = BuildContext.withNewContext {
            for lang in post.syntaxHighlighters {
                BuildContext.register(lang)
            }

            updated.pageMarkup = RenderingContext.$current.withValue(updated) {
                PostPageContent(postPage.body).markupString()
            }

            return RenderingContext.$current.withValue(updated) {
                layout.body.markupString()
            }
        }

        var searchMetadata: SearchMetadata?
        if site.isSearchEnabled, !post.description.isEmpty {
            searchMetadata = SearchMetadata(
                id: localizedURL.path(),
                title: metadata.title,
                description: metadata.description
            )
        }

        return RenderedPage(
            html: outputHTML,
            prettify: site.prettifyHTML,
            path: buildDirectory.appending(path: post.rawPath),
            priority: 0.8,
            searchMetadata: searchMetadata
        )
    }

    func render(
        _ categoryPage: any CategoryPage,
        for category: String?,
        using layout: any Layout
    ) -> RenderedPage {
        let path =
            category.map { "categories/\($0.convertedToSlug())" } ??
            "categories"

        let metadata = PageMetadata(
            title: "Categories",
            description: "Categories",
            url: localizedURL(for: path)
        )

        var updated = self
        updated.activeCategory =
            category.map { TagCategory(name: $0, posts: content(tagged: $0)) }
                ?? AllTagsCategory(posts: content(tagged: nil))

        updated.environment = EnvironmentValues(
            rootDirectory: rootDirectory,
            site: site,
            locale: locale,
            allContent: posts,
            pageMetadata: metadata
        )

        let html = RenderingContext.$current.withValue(updated) {
            layout.body.markupString()
        }

        return RenderedPage(
            html: html,
            prettify: site.prettifyHTML,
            path: buildDirectory.appending(path: path),
            priority: category == nil ? 0.7 : 0.6,
            filename: "index"
        )
    }

    func render(
        _ categoryPage: any CategoryPage,
        for category: any Category,
        using layout: any Layout
    ) -> RenderedPage {
        let path = category is AllTagsCategory
            ? "categories"
            : "categories/\(category.name.convertedToSlug())"

        let metadata = PageMetadata(
            title: "Categories",
            description: "Categories",
            url: localizedURL(for: path)
        )

        var updated = self
        updated.activeCategory = category
        updated.environment = EnvironmentValues(
            rootDirectory: rootDirectory,
            site: site,
            locale: locale,
            allContent: posts,
            pageMetadata: metadata
        )

        updated.pageMarkup = RenderingContext.$current.withValue(updated) {
            categoryPage.body.markupString()
        }

        let html = RenderingContext.$current.withValue(updated) {
            layout.body.markupString()
        }

        return RenderedPage(
            html: html,
            prettify: site.prettifyHTML,
            path: buildDirectory.appending(path: path),
            priority: category is AllTagsCategory ? 0.7 : 0.6,
            filename: "index"
        )
    }

    func render(
        _ errorPage: any ErrorPage,
        for error: HTTPError,
        using layout: any Layout
    ) -> RenderedPage {

        let path = String(error.statusCode)

        // Create a temporary minimal PageContext so
        // ErrorPage.title / description can resolve properly.
        let dummyMetadata = PageMetadata(
            title: "", description: "", url: localizedURL(for: path)
        )

        var draft = self
        draft.httpError = error
        draft.environment = EnvironmentValues(
            rootDirectory: rootDirectory,
            site: site,
            locale: locale,
            allContent: posts,
            pageMetadata: dummyMetadata
        )

        let resolvedMetadata = RenderingContext.$current.withValue(draft) {
            PageMetadata(
                title: errorPage.title,
                description: errorPage.description,
                url: localizedURL(for: path)
            )
        }

        draft.environment.page = resolvedMetadata

        draft.pageMarkup = RenderingContext.$current.withValue(draft) {
            errorPage.body.markupString()
        }

        let html = RenderingContext.$current.withValue(draft) {
            layout.body.markupString()
        }

        let resolvedPath = locale == site.defaultLocale
            ? buildDirectory
            : buildDirectory.appending(path: path)

        return RenderedPage(
            html: html,
            prettify: site.prettifyHTML,
            path: resolvedPath,
            priority: nil,
            filename: path
        )
    }

    func renderSearchResultsPage(
        _ searchPage: any SearchPage,
        using layout: any Layout
    ) -> RenderedPage {
        let path = "search"
        let metadata = PageMetadata(
            title: "Search Results",
            description: "Search Results",
            url: localizedURL(for: path)
        )

        var updated = self
        updated.searchResults = SearchResultCollection([SearchResult()])
        updated.environment = EnvironmentValues(
            rootDirectory: rootDirectory,
            site: site,
            locale: locale,
            allContent: posts,
            pageMetadata: metadata
        )

        updated.pageMarkup = RenderingContext.$current.withValue(updated) {
            searchPage.body.markupString()
        }

        let html = RenderingContext.$current.withValue(updated) {
            layout.body.markupString()
        }

        return RenderedPage(
            html: html,
            prettify: site.prettifyHTML,
            path: buildDirectory.appending(path: path),
            priority: 0.8
        )
    }

    func renderNoSearchResultsPage(
        _ searchPage: any SearchPage,
        using layout: any Layout
    ) -> RenderedPage {
        let path = "search/no-results"
        let metadata = PageMetadata(
            title: "No Results Found",
            description: "Try another search term.",
            url: localizedURL(for: path)
        )

        var updated = self
        updated.searchResults = SearchResultCollection()
        updated.environment = EnvironmentValues(
            rootDirectory: rootDirectory,
            site: site,
            locale: locale,
            allContent: posts,
            pageMetadata: metadata
        )

        updated.pageMarkup = RenderingContext.$current.withValue(updated) {
            searchPage.body.markupString()
        }

        let html = RenderingContext.$current.withValue(updated) {
            layout.body.markupString()
        }

        return RenderedPage(
            html: html,
            prettify: site.prettifyHTML,
            path: buildDirectory.appending(path: path),
            priority: 0.8
        )
    }

    func localizedPath(for path: String) -> String {
        let cleanPath = path.trimmingCharacters(in: .init(charactersIn: "/"))
        return localizedURL(for: cleanPath).path
    }

    func path(for url: URL) -> String {
        if url.isFileURL {
            site.url.appending(path: url.relativeString).decodedPath
        } else {
            url.relativeString
        }
    }

    func content(tagged tag: String?) -> [Post] {
        guard let tag else { return posts }
        return posts.filter { $0.tags?.contains(where: { $0.name == tag }) ?? false }
    }

    func localizedURL(for path: String) -> URL {
        let clean = path.trimmingCharacters(in: .init(charactersIn: "/"))
        if defaultLocale != locale {
            let loc = locale.asRFC5646.lowercased()
            return site.url.appending(path: "\(loc)/\(clean)")
        }
        return site.url.appending(path: clean)
    }
}

package extension RenderingContext {
    /// Renders all page types (home, static pages, posts, categories, error, search)
    /// and merges all BuildContext contributions.
    func render(_ site: some Site) -> (pages: [RenderedPage], buildContext: BuildContext) {
        // swiftlint:disable:previous function_body_length
        var pages: [RenderedPage] = []
        var build = BuildContext()

        func withFreshContext(_ body: () -> RenderedPage) -> RenderedPage {
            let (result, context) = BuildContext.withNewContext { body() }
            build = build.merging(context)
            return result
        }

        let homeLayout = resolvedLayout(for: site.homePage.layout, in: site)
        let home = withFreshContext {
            render(homePage: site.homePage, using: homeLayout)
        }
        pages.append(home)

        for page in site.pages {
            let layout = resolvedLayout(for: page.layout, in: site)
            let rendered = withFreshContext {
                render(page, using: layout)
            }
            pages.append(rendered)
        }

        for post in posts {
            let pageTemplate = site.postPage(for: post)
            let layout = resolvedLayout(for: pageTemplate.layout, in: site)
            let rendered = withFreshContext {
                render(post, using: pageTemplate, with: layout)
            }
            pages.append(rendered)
        }

        if !(site.categoryPage is EmptyCategoryPage) {
            for category in categories {
                let layout = resolvedLayout(for: site.categoryPage.layout, in: site)
                let rendered = withFreshContext {
                    render(site.categoryPage, for: category, using: layout)
                }
                pages.append(rendered)
            }
        }

        if !(site.errorPage is EmptyErrorPage) {
            let errorLayout = resolvedLayout(for: site.errorPage.layout, in: site)
            for error in site.handledErrors {
                let rendered = withFreshContext {
                    render(site.errorPage, for: error, using: errorLayout)
                }
                pages.append(rendered)
            }
        }

        if site.isSearchEnabled {
            let searchLayout = resolvedLayout(for: site.searchPage.layout, in: site)

            let results = withFreshContext {
                renderSearchResultsPage(site.searchPage, using: searchLayout)
            }
            pages.append(results)

            let noResults = withFreshContext {
                renderNoSearchResultsPage(site.searchPage, using: searchLayout)
            }
            pages.append(noResults)
        }

        return (pages, build)
    }
}
