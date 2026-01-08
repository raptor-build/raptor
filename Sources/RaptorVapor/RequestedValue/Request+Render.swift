//
// Request+Render.swift
// RaptorVapor
// https://raptor.build
// See LICENSE for license information.
//

public extension Request {
    /// Renders any `PageRepresentable` using the full Raptor SSR pipeline,
    /// including TaskLocal propagation, BuildContext isolation, and
    /// locale-aware rendering.
    ///
    /// Locale is inferred from the request URL:
    /// - `/` → default locale
    /// - `/en/...` → "en"
    /// - `/it/...` → "it"
    func render(_ page: some PageRepresentable) throws -> Response {
        let servedSite = application.site

        return try renderPage(for: self, in: servedSite) { renderer in
            if let page = page as? any Page {
                let layout = servedSite.layout(for: page)
                return renderer.render(page, using: layout)
            }

            fatalError("Unsupported PageRepresentable: \(type(of: page))")
        }
    }

    /// Renders a single `Post` via SSR, using the correct localized renderer
    /// and layout resolution rules.
    func render(_ post: Post) throws -> Response {
        let site = application.site
        return try renderPage(for: self, in: site) { renderer in
            let postPage = site.postPage(for: post)
            let layout = site.layout(for: postPage)
            return renderer.render(post, using: postPage, with: layout)
        }
    }
}
