//
// InlineText.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

import Foundation
import Testing

@testable import Raptor

/// Tests for the `InlineText` element.
@Suite("InlineText Tests")
struct InlineTextTests {
    @Test("Single Element", arguments: ["This is a test", "Another test"])
    func singleElement(spanText: String) {
        let element = InlineText(spanText)
        let output = element.markupString()

        #expect(output == "<span>\(spanText)</span>")
    }

    @Test("Builder", arguments: ["This is a test", "Another test"])
    func builder(spanText: String) {
        let element = InlineText { spanText }
        let output = element.markupString()

        #expect(output == "<span>\(spanText)</span>")
    }

    @Test("Single Element", arguments: ["This is a test", "Another test", ""])
    func singleElement(strongText: String) {
        let element = InlineText(strongText).bold()
        let output = element.markupString()

        #expect(output == "<strong>\(strongText)</strong>")
    }

    @Test("Builder", arguments: ["This is a test", "Another test", ""])
    func builder(strongText: String) {
        let element = InlineText { strongText }.bold()
        let output = element.markupString()

        #expect(output == "<strong>\(strongText)</strong>")
    }

    @Test("Emphasis")
    func simpleEmphasis() {
        let element = InlineText("Although Markdown is still easier, to be honest! ").italic()
        let output = element.markupString()

        #expect(output == "<em>Although Markdown is still easier, to be honest! </em>")
    }
}
