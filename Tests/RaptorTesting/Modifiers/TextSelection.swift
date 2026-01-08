//
//  TextSelection.swift
//  Raptor
//  https://raptor.build
//  See LICENSE for license information.
//

import Foundation
import Testing

@testable import Raptor

/// Tests for the `TextSelection` modifier.
@Suite("TextSelection Tests")
struct TextSelectionTests {
    @Test("Text Selection", arguments: TextSelection.allCases)
    func textSelection(selection: TextSelection) {
        let element = Text("Hello").textSelection(selection)
        let output = element.markupString()

        #expect(output == "<p style=\"user-select: \(selection.rawValue)\">Hello</p>")
    }
}
