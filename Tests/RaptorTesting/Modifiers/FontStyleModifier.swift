//
//  FontStyleModifier.swift
//  Raptor
//  https://raptor.build
//  See LICENSE for license information.
//

import Foundation
import Testing

@testable import Raptor

/// Tests for the `FontStyleModifier` modifier.
@Suite("FontStyleModifier Tests")
struct FontStyleModifierTests {
    private static let tagBasedStyles: [Font.Style] = [
        .title1, .title2, .title3, .title4, .title5, .title6, .body
    ]

    @Test("Font Style", arguments: tagBasedStyles)
    func fontStyle(style: Font.Style) {
        let element = Text("Hello").font(style)
        let output = element.markupString()
        #expect(output == "<\(style.description)>Hello</\(style.description)>")
    }
}
