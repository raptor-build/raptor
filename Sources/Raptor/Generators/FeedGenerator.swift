//
// FeedGenerator.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

import Foundation

struct FeedGenerator: Sendable {
    var feedConfig: FeedConfiguration
    var site: SiteContext
    var content: [Post]
    var locale: Locale

    init(
        config: FeedConfiguration,
        site: SiteContext,
        content: [Post],
        locale: Locale
    ) {
        self.feedConfig = config
        self.site = site
        self.content = content
        self.locale = locale
    }

    func generateFeed() -> String {
        let contentXML = generateContentXML()
        var result = generateRSSHeader()

        if let image = feedConfig.image {
            result += """
            <image>\
            <url>\(image.url)</url>\
            <title>\(site.name)</title>\
            <link>\(site.url.absoluteString)</link>\
            <width>\(image.width)</width>\
            <height>\(image.height)</height>\
            </image>
            """
        }

        result += """
        \(contentXML)\
        </channel>\
        </rss>
        """

        return result
    }

    private func generateContentXML() -> String {
        content
            .prefix(feedConfig.contentCount)
            .map { item in
                let path = item.absoluteURL(in: site)

                var itemXML = """
                <item>\
                <guid isPermaLink="true">\(path)</guid>\
                <title>\(item.title)</title>\
                <link>\(path)</link>\
                <description><![CDATA[\(item.description)]]></description>\
                <pubDate>\(item.date.asRFC822(locale: locale))</pubDate>
                """

                let authorName = item.author ?? site.author

                if site.author.isEmpty == false {
                    itemXML += "<dc:creator><![CDATA[\(authorName)]]></dc:creator>"
                }

                item.tags?.forEach { tag in
                    itemXML += "<category><![CDATA[\(tag)]]></category>"
                }

                if feedConfig.mode == .full {
                    itemXML += """
                    <content:encoded>\
                    <![CDATA[\(item.text.content.makingAbsoluteLinks(relativeTo: site.url))]]>\
                    </content:encoded>
                    """
                }

                itemXML += "</item>"
                return itemXML
            }.joined()
    }

    func generateRSSHeader() -> String {
        let feedURL = site.url
            .appending(path: feedConfig.path)
            .absoluteString

        return """
        <?xml version="1.0" encoding="UTF-8" ?>\
        <rss version="2.0" \
        xmlns:dc="http://purl.org/dc/elements/1.1/" \
        xmlns:atom="http://www.w3.org/2005/Atom" \
        xmlns:content="http://purl.org/rss/1.0/modules/content/">\
        <channel>\
        <title>\(site.name) (\(locale.displayName))</title>\
        <description>\(site.description ?? "")</description>\
        <link>\(site.url.absoluteString)</link>\
        <atom:link href="\(feedURL)" rel="self" type="application/rss+xml" />\
        <language>\(locale.asRFC5646)</language>\
        <generator>\(Raptor.version)</generator>
        """
    }
}
