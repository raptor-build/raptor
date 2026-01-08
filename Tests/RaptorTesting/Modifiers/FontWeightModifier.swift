//
//  FontWeightModifier.swift
//  Raptor
//  https://raptor.build
//  See LICENSE for license information.
//

import Foundation
import Testing

@testable import Raptor

/// Tests for the `FontWeightModifier` modifier.
@Suite("FontWeightModifier Tests")
struct FontWeightModifierTests {
    @Test("Font Weight Modifier", arguments: Font.Weight.allCases)
    func fontWeight(weight: Font.Weight) {
        let element = Text("Hello").fontWeight(weight)
        let output = element.markupString()
        #expect(output == "<p style=\"font-weight: \(weight.rawValue)\">Hello</p>")
    }
}
