//
//  Quote.swift
//  Raptor
//  https://raptor.build
//  See LICENSE for license information.
//

import Foundation
import Testing

@testable import Raptor

/// Tests for the `Quote` element.
@Suite("Quote Tests")
struct QuoteTests {
    @Test("Plain Quote", arguments: ["It is a truth universally acknowledged..."])
    func plainQuoteTest(quoteText: String) {
        let element = Quote {
            Text(quoteText)
        }

        let output = element.markupString()

        #expect(output == """
        <blockquote class="blockquote">\
        <p>\(quoteText)</p>\
        </blockquote>
        """)
    }

    @Test("Quote With Caption", arguments: ["Stay hungry. Stay foolish."], ["Steve Jobs"])
    func quoteWithCaptionTest(quoteText: String, captionText: String) {
        let element = Quote {
            Text(quoteText)
        } caption: {
            captionText
        }

        let output = element.markupString()

        #expect(output == """
        <blockquote class="blockquote">\
        <p>\(quoteText)</p>\
        <footer class="blockquote-footer">\(captionText)</footer>\
        </blockquote>
        """)
    }
}
