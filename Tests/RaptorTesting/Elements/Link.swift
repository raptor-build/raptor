//
// Link.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

import Foundation
import Testing

@testable import Raptor

/// Tests for the `Link` element.
@Suite("Link Tests")
struct LinkTests {
    private typealias SendableSite = Site & Sendable
    private typealias SendablePage = Page & Sendable
    private static let sites: [any SendableSite] = [TestSite(), TestSubsite()]
    private static let pages: [any SendablePage] = [TestPage(), TestSubsitePage()]

    @Test("String Target", arguments: [(target: "/", description: "Go Home")], Self.sites)
    private func target(for link: (target: String, description: String), for site: any SendableSite) {
        withTestRenderingEnvironment { context in
            let element = Link(link.description, destination: link.target)
            let output = element.markupString()

            let expectedPath = context.path(for: URL(string: link.target)!)
            #expect(output == "<a href=\"\(expectedPath)\">\(link.description)</a>")
        }
    }

    @Test("Page Target", arguments: zip(Self.pages, Self.sites))
    private func target(for page: any SendablePage, site: any SendableSite) {
        withTestRenderingEnvironment { context in
            let element = Link("This is a test", destination: page)
            let output = element.markupString()

            let expectedPath = context.path(for: URL(string: page.path)!)
            #expect(output == "<a href=\"\(expectedPath)\">This is a test</a>")
        }
    }

    @Test("Page Content", arguments: zip(Self.pages, Self.sites))
    private func content(for page: any SendablePage, site: any SendableSite) {
        withTestRenderingEnvironment { context in
            let element = LinkGroup(destination: page) {
                "MORE "
                Text("CONTENT")
            }
            let output = element.markupString()

            let expectedPath = context.path(for: URL(string: page.path)!)
            #expect(output == "<a href=\"\(expectedPath)\" class=\"link-plain d-inline-block\">MORE <p>CONTENT</p></a>")
        }
    }

    @Test("Privacy Sensitive Modifier",
          arguments: [PrivacyEncoding.urlOnly, PrivacyEncoding.urlAndDisplay])
    func privacySensitive(encoding: PrivacyEncoding) {
        let element = Link("Go Home", destination: "/").privacySensitive(encoding)

        let output = withTestRenderingEnvironment {
            element.markupString()
        }

        #expect(output.contains("privacy-sensitive=\"\(encoding.rawValue)\""))
        #expect(output.contains("protected-link"))
    }
}
