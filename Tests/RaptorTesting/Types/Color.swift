//
//  Color.swift
//  Raptor
//  https://raptor.build
//  See LICENSE for license information.
//

import Foundation
import Testing

@testable import Raptor

/// Tests for the `Color` type.
@Suite("Tests for the `Color` type")
struct ColorTypeTests {
    @Test("CSS values via parameters", arguments: zip(
        [Color.black, .white],
        ["0 0 0", "255 255 255"]))
    func makeColor(color: Color, rgbValues: String) {
        #expect(color.description == "rgb(" + rgbValues + " / 100%)")
    }

    @Test("Color init with Int values")
    func testInitializeWithIntValues() {
        let color = Color(red: 255, green: 0, blue: 0)
        #expect(color.red == 255)
        #expect(color.green == 0)
        #expect(color.blue == 0)
    }

    @Test("CSS color value")
    func testReturnCSSValueOfColor() {
        let red = 255
        let green = 0
        let blue = 0
        let color = Color(red: red, green: green, blue: blue)

        #expect(color.description == "rgb(\(red) \(blue) \(green) / 100%)")
    }

    @Test("Opacity")
    func testReturnCSSColorValueWithOpacity() {
        let red = 255
        let green = 0
        let blue = 0
        let opacity = 50%
        let color = Color(red: red, green: green, blue: blue, opacity: opacity)

        #expect(color.description == "rgb(\(red) \(blue) \(green) / \(opacity.roundedValue)%)")
    }

    @Test("Double to Int Conversion in init(red:green:blue:opacity:)")
    func rbgaInitWithDouble() {
        let color = Color(red: 1.0, green: 1.0, blue: 1.0, opacity: 1.0)
        #expect(color.description == "rgb(255 255 255 / 100%)")
    }

    @Test("Double to Int Conversion in init(white:opacity:)")
    func whiteAndOpacityInitWithDouble() {
        let color = Color(white: 1.0, opacity: 1.0)
        #expect(color.description == "rgb(255 255 255 / 100%)")
    }
}
