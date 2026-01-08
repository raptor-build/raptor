//
//  Clipped.swift
//  Raptor
//  https://raptor.build
//  See LICENSE for license information.
//

import Foundation
import Testing

@testable import Raptor

/// Tests for the `Clipped` modifier.
@Suite("Clipped Tests")
struct ClippedTests {
    @Test("Clipped Modifier")
    func clippedModifier() {
        let element = Text("Hello").clipped()
        let output = element.markupString()
        #expect(output == "<p style=\"overflow: hidden\">Hello</p>")
    }

    @Test("Clipped Modifier on Custom Element")
    func clippedModifier_onCustomElement() {
        let element = TestElement().clipped()
        let output = element.markupString()
        #expect(output == """
        <div style=\"overflow: hidden\">\
        <p>Test Heading!</p>\
        <p>Test Subheading</p>\
        <label>Test Label</label>\
        </div>
        """)
    }
}
