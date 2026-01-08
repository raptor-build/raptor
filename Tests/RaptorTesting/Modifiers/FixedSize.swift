//
//  FixedSize.swift
//  Raptor
//  https://raptor.build
//  See LICENSE for license information.
//

import Foundation
import Testing

@testable import Raptor

/// Tests for the `FixedSize` modifier.
@Suite("FixedSize Tests")
struct FixedSizeTests {
    @Test("FixedSize Modifier")
    func fixedSizeModifier() {
        let element = Text("Hello").fixedSize()
        let output = element.markupString()
        #expect(output == "<p style=\"width: fit-content\">Hello</p>")
    }
}
