//
//  CornerRadius.swift
//  Raptor
//  https://raptor.build
//  See LICENSE for license information.
//

import Foundation
import Testing

@testable import Raptor

/// Tests for the `CornerRadius` modifier.
@Suite("CornerRadius Tests")
struct CornerRadiusTests {
    @Test("CornerRadius Modifier with All Edges")
    func cornerRadiusWithAllEdgesString() {
        let element = Text("Hello").cornerRadius(5)
        let output = element.markupString()
        #expect(output == "<p style=\"corner-shape: round; border-radius: 5px\">Hello</p>")
    }

    @Test("CornerRadius Modifier with Specific Edges")
    func cornerRadiusWithSpecificEdgesPixels() {
        let element = Text("Hello").cornerRadius([.topLeading, .bottomTrailing], 10)
        let output = element.markupString()
        #expect(output.contains("border-top-left-radius: 10px"))
        #expect(output.contains("border-bottom-right-radius: 10px"))
        #expect(!output.contains("border-top-right-radius"))
        #expect(!output.contains("border-bottom-left-radius"))
    }
}
