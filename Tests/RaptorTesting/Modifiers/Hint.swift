//
//  Hint.swift
//  Raptor
//  https://raptor.build
//  See LICENSE for license information.
//

import Foundation
import Testing

@testable import Raptor

/// Tests for the `Hint` modifier.
@Suite("Hint Tests")
struct HintTests {
    @Test("Markdown Hint")
    func markdownHint() {
        let element = Text {
            InlineText("Hover over me")
                .help("Why, hello there!")
        }

        let output = element.markupString()
        #expect(output == "<p><span title=\"Why, hello there!\">Hover over me</span></p>")
    }
}
