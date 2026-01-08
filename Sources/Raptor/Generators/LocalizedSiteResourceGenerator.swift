//
// LocalizedSiteResourceGenerator.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

package struct LocalizedSiteResourceGenerator {
    /// The site that is currently being built.
    let site: SiteContext

    /// The directory containing their final, built website.
    let buildDirectory: URL

    package init(site: SiteContext, buildDirectory: URL) {
        self.site = site
        self.buildDirectory = buildDirectory
    }

    /// Generates a sitemap.xml file for this site.
    package func generateSiteMap(locations: [Location], locale: Locale) {
        let generator = SiteMapGenerator(site: site, siteMap: locations, locale: locale)
        let siteMap = generator.generateSiteMap()

        let outputURL = buildDirectory.appending(path: "sitemap.xml")

        do {
            try siteMap.write(to: outputURL, atomically: true, encoding: .utf8)
        } catch {
            fatalError(BuildError.failedToCreateBuildFile(outputURL).description)
        }
    }

    /// Generates an RSS feed for this site, if enabled.
    package func generateFeed(locale: Locale, content: [Post]) {
        guard let feedConfig = site.feedConfiguration else { return }
        let localizedContent = content.filter { $0.locale == locale }

        let generator = FeedGenerator(
            config: feedConfig,
            site: site,
            content: localizedContent,
            locale: locale
        )

        let result = generator.generateFeed()

        let isLocalized = site.isMultilingual && !locale.isDefault(for: site)
        let destination: URL

        if isLocalized {
            destination = buildDirectory
                .appending(path: locale.asRFC5646.lowercased())
                .appending(path: feedConfig.path)
        } else {
            destination = buildDirectory.appending(path: feedConfig.path)
        }

        do {
            try result.write(to: destination, atomically: true, encoding: .utf8)
        } catch {
            BuildContext.logError(.failedToWriteFeed)
        }
    }

    /// Generates a search index for the current locale.
    ///
    /// When called from `generateLocalizedContent(for:)`, this writes a localized
    /// search index (e.g. `/it/search-index.json`). For the default locale, it also
    /// writes a global `/search-index.json` at the build root.
    ///
    /// Each entry includes minimal metadata for Lunr.js: `id`, `title`,
    /// `description`, `tags`, and an optional formatted `date`.
    package func generateSearchIndex(from searchMetadata: [SearchMetadata], for locale: Locale) {
        let searchableDocuments = searchMetadata.map { metadatum -> [String: Any] in
            [
                "id": metadatum.id,
                "title": metadatum.title,
                "description": metadatum.description,
                "tags": metadatum.tags?.joined(separator: ",") ?? "",
                "date": metadatum.date?.formatted(date: .long, time: .omitted) ?? ""
            ]
        }

        do {
            let jsonData = try JSONSerialization.data(
                withJSONObject: searchableDocuments,
                options: .prettyPrinted
            )

            // Write to current locale’s build directory (e.g. /Build/it/search-index.json)
            let localizedPath = buildDirectory.appending(path: "search-index.json")
            try jsonData.write(to: localizedPath)

            // If this is the default locale, also write a global index to /Build/search-index.json
            if locale.isDefault(for: site) {
                let rootBuildDir = buildDirectory
                let globalPath = rootBuildDir.appending(path: "search-index.json")
                try jsonData.write(to: globalPath)
            }

        } catch {
            BuildContext.logError(.failedToWriteFile("search-index.json"))
        }
    }
}
