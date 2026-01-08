//
// SiteMapGenerator.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

import Foundation

/// Generates `sitemap.xml` files for a site, including localized versions and a sitemap index when applicable.
struct SiteMapGenerator: Sendable {
    var site: SiteContext
    var siteMap: [Location]
    var locale: Locale

    /// Generates a sitemap for the current locale, including URLs and priorities.
    /// - Returns: A complete XML string representing a single sitemap.
    func generateSiteMap() -> String {
        let baseURL = site.url
        let locale = locale
        let isDefaultLocale = locale == site.defaultLocale
        let isLocalized = site.isMultilingual && !isDefaultLocale

        let prefix = isLocalized ? "/\(locale.asRFC5646.lowercased())" : ""

        let urls = siteMap.map { entry in
            let absolute = baseURL.appendingPathComponent(prefix + "/" + entry.path).absoluteString
            return """
            <url>
              <loc>\(absolute)</loc>
              <priority>\(entry.priority)</priority>
            </url>
            """
        }.joined(separator: "\n")

        return """
        <?xml version="1.0" encoding="UTF-8"?>
        <urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">
        \(urls)
        </urlset>
        """
    }

    /// Generates a top-level `sitemap.xml` index when multiple locales are configured.
    ///
    /// This method creates a single `sitemapindex` file in the root of the build directory,
    /// referencing each locale-specific sitemap (e.g., `/en-us/sitemap.xml`, `/it/sitemap.xml`).
    /// Search engines can use this index to discover all localized versions of the site.
    ///
    /// - Returns: None. Writes `sitemap.xml` directly into the root of the build directory.
    static func generateSitemapIndex(for site: SiteContext) -> String? {
        guard site.isMultilingual else { return nil }

        let indexXML = site.locales.map { locale in
            let id = locale.asRFC5646.lowercased()
            return "<sitemap><loc>\(site.url.absoluteString)\(id)/sitemap.xml</loc></sitemap>"
        }.joined(separator: "\n")

        return """
        <?xml version="1.0" encoding="UTF-8"?>
        <sitemapindex xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">
        \(indexXML)
        </sitemapindex>
        """
    }
}
