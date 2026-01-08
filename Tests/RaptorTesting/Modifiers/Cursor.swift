//
//  Cursor.swift
//  Raptor
//  https://raptor.build
//  See LICENSE for license information.
//

import Foundation
import Testing

@testable import Raptor

/// Tests for the `Cursor` modifier.
@Suite("Cursor Tests")
struct CursorTests {
    @Test("Cursor Modifier", arguments: Cursor.allCases)
    func cursorModifier(_ cursor: Cursor) {
        let element = InlineText("Hello, World!").cursor(cursor)
        let output = element.markupString()

        #expect(output == "<span style=\"cursor: \(cursor.rawValue)\">Hello, World!</span>")
    }

    @Test("Cursor Modifier on Custom Element", arguments: Cursor.allCases)
    func cursorModifier_onCustomElement(_ cursor: Cursor) {
        let element = TestElement().cursor(cursor)
        let output = element.markupString()
        #expect(output == """
        <div style=\"cursor: \(cursor.rawValue)\">\
        <p>Test Heading!</p>\
        <p>Test Subheading</p>\
        <label>Test Label</label>\
        </div>
        """)
    }
}
