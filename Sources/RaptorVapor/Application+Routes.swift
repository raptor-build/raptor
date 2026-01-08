//
// Application+Routes.swift
// RaptorVapor
// https://raptor.build
// See LICENSE for license information.
//

extension Application {
    /// Registers all Raptor-powered routes inside a Vapor application.
    /// - Parameter site: The site used to determine which routes exist.
    func registerRaptorRoutes() {
        registerLocalizedRoutes(localePrefix: nil)

        for locale in site.locales.dropFirst() {
            let prefix = locale.asRFC5646.lowercased()
            registerLocalizedRoutes(localePrefix: prefix)
        }

        registerServerActionRoute()
    }

    /// Registers all routes for a specific locale prefix.
    /// - Parameter localePrefix:
    ///   `nil` → default locale (`/`)
    ///   `"en"` → `/en/...`
    private func registerLocalizedRoutes(localePrefix: String?) {
        // swiftlint:disable:previous function_body_length
        let routes = localePrefix == nil
            ? self.routes
            : self.routes.grouped(PathComponent.constant(localePrefix!))

        routes.get { [self] request throws in
            try renderPage(for: request, in: site) { renderer in
                let layout = site.layout(for: site.homePage)
                return renderer.render(homePage: site.homePage, using: layout)
            }
        }

        for page in site.pages {
            let components = page.path.split(separator: "/").map { PathComponent.constant(String($0)) }
            let pageType = type(of: page)

            routes.get(components) { [self] request throws in
                guard let page = site.pages.first(where: { type(of: $0) == pageType }) else {
                    throw Abort(.notFound)
                }

                let layout = site.layout(for: page)

                return try renderPage(for: request, in: site) { renderer in
                    renderer.render(page, using: layout)
                }
            }
        }

        routes.get(":slug") { [self] request in
            let locale = request.locale()
            let slug = request.parameters.get("slug")!

            guard let post = site.posts.first(where: { $0.rawPath == slug && $0.locale == locale }) else {
                throw Abort(.notFound)
            }

            return try renderPage(for: request, in: site) { renderer in
                let page = site.postPage(for: post)
                let layout = site.layout(for: page)
                return renderer.render(post, using: page, with: layout)
            }
        }

        if !(site.categoryPage is EmptyCategoryPage) {
            routes.get("categories") { [self] request throws in
                try renderPage(for: request, in: site) { renderer in
                    let layout = site.layout(for: site.categoryPage)
                    return renderer.render(site.categoryPage, for: nil, using: layout)
                }
            }

            routes.get("categories", ":category") { [self] request throws in
                let category = request.parameters.get("category")
                return try renderPage(for: request, in: site) { renderer in
                    let layout = site.layout(for: site.categoryPage)
                    return renderer.render(site.categoryPage, for: category, using: layout)
                }
            }
        }

        if site.isSearchEnabled {
            routes.get("search") { [self] request throws in
                try renderPage(for: request, in: site) { renderer in
                    let layout = site.layout(for: site.searchPage)
                    return renderer.renderSearchResultsPage(site.searchPage, using: layout)
                }
            }

            routes.get("search", "no-results") { [self] request throws in
                try renderPage(for: request, in: site) { renderer in
                    let layout = site.layout(for: site.searchPage)
                    return renderer.renderNoSearchResultsPage(site.searchPage, using: layout)
                }
            }
        }
    }

    /// Registers Raptor's POST /_actions/:id endpoint.
    private func registerServerActionRoute() {
        post("_actions", ":id") { request async throws in
            try await ActionRouter.shared.route(request)
        }
    }
}
