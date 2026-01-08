//
//  Background.swift
//  Raptor
//  https://raptor.build
//  See LICENSE for license information.
//

import Foundation
import Testing

@testable import Raptor

/// Tests for the `Background` modifier.
@Suite("Background Tests")
struct BackgroundTests {
    private static let testMaterial: [Material] = [
        .ultraThinMaterial,
        .thinMaterial,
        .regularMaterial,
        .thickMaterial,
        .ultraThickMaterial
    ]

    private static let testGradient: [Gradient] = [
        Gradient(colors: [.white, .black], type: .radial),
        Gradient(colors: [.white, .black], type: .linear(angle: 10)),
        Gradient(colors: [.white, .black], type: .conic(angle: 10))
    ]

    @Test("Background modifier with Color on Text")
    func textWithColorBackground() {
        let element = Text("Hello, world!").background(.teal)
        let output = element.markupString()

        #expect(output == "<p style=\"background-color: var(--r-teal)\">Hello, world!</p>")
    }

    @Test("Background modifier with Material on Text", arguments: Self.testMaterial)
    func textWithMaterialBackground(material: Material) {
        let element = Text("Hello, world!").background(material)
        let output = element.markupString()

        #expect(output == "<p class=\"\(material.className)\">Hello, world!</p>")
    }

    @Test("Gradient Background Test", arguments: Self.testGradient)
    func textWithGradientBackground(gradient: Gradient) {
        let element = Text("Hello, world!").background(gradient)
        let output = element.markupString()

        #expect(output == "<p style=\"background-image: \(gradient.description)\">Hello, world!</p>")
    }
}
