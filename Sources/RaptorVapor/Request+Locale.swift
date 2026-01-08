//
// Request+Locale.swift
// RaptorVapor
// https://raptor.build
// See LICENSE for license information.
//

extension Request {
    /// Determines the locale for this request by inspecting the first
    /// path segment and matching it to supported locales.
    func locale() -> Locale {
        let site = application.site.context
        let defaultLocale = site.locales.first ?? .automatic

        // The locale prefix is ALWAYS the first path component
        let firstComponent = self.parameters.get("locale")
        ?? self.url.path.split(separator: "/").first.map(String.init)

        guard
            let id = firstComponent,
            let locale = site.locales.first(where: { $0.asRFC5646.lowercased() == id.lowercased() })
        else {
            return defaultLocale
        }

        return locale
    }
}
