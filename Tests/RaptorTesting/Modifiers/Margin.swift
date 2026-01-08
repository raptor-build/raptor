//
//  Margin.swift
//  Raptor
//  https://raptor.build
//  See LICENSE for license information.
//

import Foundation
import Testing

@testable import Raptor

/// Tests for the `Margin` modifier.
@Suite("Margin Tests")
struct MarginTests {
    @Test("Default margin applies 20px to all edges")
    func defaultMargin() {
        let element = Text("Hello, world!").margin()
        let output = element.markupString()

        #expect(output == "<p style=\"margin: 20px\">Hello, world!</p>")
    }

    @Test("Margin modifier with custom pixel value", arguments: [40, 0, -40])
    func customPixelMargin(value: Double) {
        let element = Text("Hello, world!").margin(value)
        let output = element.markupString()

        let formatted = value.formatted(.nonLocalizedDecimal)
        #expect(output == "<p style=\"margin: \(formatted)px\">Hello, world!</p>")
    }

    @Test("Margin modifier with amount value", arguments: SemanticSpacing.allCases)
    func amountUnitMargin(amount: SemanticSpacing) {
        let element = Text("Hello, world!").margin(amount)
        let output = element.markupString()

        #expect(output == "<p class=\"m-\(amount.rawValue)\">Hello, world!</p>")
    }

    @Test("Margin on selected sides with default pixels", arguments: zip(
        [Edge.top, .bottom, .leading, .trailing],
        ["margin-top", "margin-bottom", "margin-left", "margin-right"]))
    func selectedEdgeMargin(alignment: Edge, property: String) {
        let element = Text("Hello, world!").margin(alignment)
        let output = element.markupString()

        #expect(output == "<p style=\"\(property): 20px\">Hello, world!</p>")
    }

    @Test("Margin with custom pixel value and multiple edges")
    func customValueAndEdgeMargin() {
        let element = Text("Hello, world!").margin(.top, 25).margin(.leading, 10)
        let output = element.markupString()

        #expect(output == "<p style=\"margin-top: 25px; margin-left: 10px\">Hello, world!</p>")
    }

    @Test("Margin on selected side with specified amount")
    func selectedEdgeMarginWithAmount() {
        let element = Text("Hello, world!").margin(.top, .medium)
        let output = element.markupString()

        #expect(output == "<p class=\"mt-3\">Hello, world!</p>")
    }
}
