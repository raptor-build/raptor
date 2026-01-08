//
//  LineSpacing.swift
//  Raptor
//  https://raptor.build
//  See LICENSE for license information.
//

import Foundation
import Testing

@testable import Raptor

/// Tests for the `LineSpacing` modifier.
@Suite("LineSpacing Tests")
struct LineSpacingTests {
    @Test("Custom Line Spacing", arguments: zip([2.5, 0.0, -2.0], ["2.5", "0", "-2"]))
    func lineSpacing(value: Double, expected: String) {
        let element = Text("Hello, world!").lineSpacing(value)
        let output = element.markupString()

        #expect(output == "<p style=\"line-height: \(expected)\">Hello, world!</p>")
    }
}
