//
//  TextDecoration.swift
//  Raptor
//  https://raptor.build
//  See LICENSE for license information.
//

import Foundation
import Testing

@testable import Raptor
@testable import RaptorHTML

/// Tests for the `TextDecoration` modifier.
@Suite("TextDecoration Tests")
struct TextDecorationModifierTests {
    @Test("Text Decoration Modifier", arguments: [TextDecoration.underline, .overline, .lineThrough])
    func textDecorationNone(_ decoration: TextDecoration) {
        let element = InlineText("Hello, World!").textDecoration(decoration)
        let output = element.markupString()

        #expect(output == "<span style=\"text-decoration: \(decoration.css)\">Hello, World!</span>")
    }
}
