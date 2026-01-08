//
// FeedGenerator.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

import Foundation
import Testing

@testable import Raptor

/// Tests for the `FeedGenerator` type.
@Suite("FeedGenerator Tests")
struct FeedGeneratorTests {
    private typealias SendableSite = Site & Sendable
    private static let sites: [any SendableSite] = [
        TestSite(),
        TestSite(locale: .englishUnitedKingdom),
        TestSite(locale: .english)
    ]

    @Test("generateFeed()", arguments: sites)
    private func generateFeed(for site: any SendableSite) async throws {
        let locale = try #require(site.locales.first)
        withTestRenderingEnvironment {
            let config = site.feedConfiguration!
            let feedHref = site.url.appending(path: config.path).absoluteString

            var examplePost = Post()
            examplePost.title = "Example Title"
            examplePost.description = "Example Description"

            let generator = FeedGenerator(
                config: config,
                site: site.context,
                content: [examplePost],
                locale: locale
            )

            let output = generator.generateFeed()

            #expect(output.contains(#"<rss version="2.0""#))
            #expect(output.contains("<channel>"))
            #expect(output.contains("<title>\(site.name)</title>"))
            #expect(output.contains("<link>\(site.url.absoluteString)</link>"))
            #expect(output.contains("<language>\(locale.asRFC5646)</language>"))
            #expect(output.contains("<generator>\(Raptor.version)</generator>"))

            #expect(output.contains(feedHref))

            #expect(output.contains("<item>"))
            #expect(output.contains("<title>\(examplePost.title)</title>"))
            #expect(output.contains("<link>\(site.url.absoluteString)</link>"))
            #expect(output.contains("<guid isPermaLink=\"true\">"))

            // pubDate: validate RFC 822 output, not exact string
            let expectedPubDate = examplePost.date.asRFC822(locale: locale)
            #expect(output.contains("<pubDate>\(expectedPubDate)</pubDate>"))
        }
    }
}
