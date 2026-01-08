//
//  ForegroundStyle.swift
//  Raptor
//  https://raptor.build
//  See LICENSE for license information.
//

import Foundation
import Testing

@testable import Raptor

/// Tests for the `ForegroundStyle` modifier.
@Suite("ForegroundStyle Tests")
struct ForegroundStyleTests {
    private static let testColors: [Color] = [.gray, .pink, .red, .green, .blue]

    private static let testRGBs = [
        "var(--r-gray)",
        "var(--r-pink)",
        "var(--r-red)",
        "var(--r-green)",
        "var(--r-blue)"
    ]

    @Test("Color Foreground Styles", arguments: zip(Self.testColors, Self.testRGBs))
    func colorForegroundStyle(color: Color, value: String) {
        let element = Text("Hello").foregroundStyle(color)
        let output = element.markupString()
        #expect(output == "<p style=\"color: \(value)\">Hello</p>")
    }
}
