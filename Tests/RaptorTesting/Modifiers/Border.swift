//
//  Border.swift
//  Raptor
//  https://raptor.build
//  See LICENSE for license information.
//

import Foundation
import Testing

@testable import Raptor

/// Tests for the `BorderModifier` modifier.
@Suite("BorderModifier Tests")
struct BorderModifierTests {
    @Test("Border Modifier with All Edges")
    func borderWithAllEdges() {
        let element = Text("Hello").border(.red, width: 2.0, style: .solid, edges: .all)
        let output = element.markupString()
        #expect(output == "<p style=\"border: 2px solid var(--r-red)\">Hello</p>")
    }

    @Test("Border Modifier with Specific Edges")
    func borderWithSpecificEdges() {
        let element = Text("Hello").border(.blue, width: 1.0, style: .dotted, edges: [.top, .bottom])
        let output = element.markupString()

        #expect(output.contains("border-top: 1px dotted var(--r-blue)"))
        #expect(output.contains("border-bottom: 1px dotted var(--r-blue)"))
        #expect(!output.contains("border-left"))
        #expect(!output.contains("border-right"))
    }
}
