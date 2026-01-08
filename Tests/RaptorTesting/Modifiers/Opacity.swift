//
//  Opacity.swift
//  Raptor
//  https://raptor.build
//  See LICENSE for license information.
//

import Foundation
import Testing

@testable import Raptor

/// Tests for the `Opacity` modifier.
@Suite("Opacity Tests")
struct OpacityTests {
    @Test("Text Opacity", arguments: ["This is a test", "Another test"])
    func textOpacity(text: String) {
        let element = Text(text).opacity(0.5)
        let output = element.markupString()

        #expect(output == "<p style=\"--r-opacity: 0.500; opacity: var(--r-opacity)\">\(text)</p>")
    }

    @Test("Image Opacity", arguments: [(path: "/images/example.jpg", description: "Example image")])
    func imageOpacity(image: (path: String, description: String)) {
        let element = Image(image.path, description: image.description).opacity(0.2)
        let output = withTestRenderingEnvironment {
            element.markupString()
        }

        #expect(output == """
        <img src=\"\(image.path)\" alt=\"\(image.description)\" \
        style=\"--r-opacity: 0.200; opacity: var(--r-opacity)\" />
        """)
    }

    @Test("Checks that the opacity value is correctly formatted", arguments: zip(
        [0.123456, 0.15, 0.1, 0.45678, 0],
        ["0.123", "0.150", "0.100", "0.457", "0.000"]))
    func opacityFormatting(value: Double, css: String) {
        let element = Text("Test").opacity(value)
        let output = element.markupString()

        #expect(output == "<p style=\"--r-opacity: \(css); opacity: var(--r-opacity)\">Test</p>")
    }
}
