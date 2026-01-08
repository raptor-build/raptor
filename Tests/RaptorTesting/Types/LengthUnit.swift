//
//  LengthUnit.swift
//  Raptor
//  https://raptor.build
//  See LICENSE for license information.
//

import Foundation
import Testing

@testable import Raptor

/// Tests for the `LengthUnit` type.
@Suite("LengthUnit Tests")
struct LengthUnitTests {
    @Test("Pixels length unit", arguments: [10, 25, 152])
    func pixels(pixelAmount: Int) {
        let element = LengthUnit.px(pixelAmount)
        #expect(element.description == "\(pixelAmount)px")
    }

    @Test("rem length unit", arguments: [10, 25, 152])
    func rem(pixelAmount: Double) {
        let element = LengthUnit.rem(pixelAmount)
        #expect(element.description == "\(pixelAmount.formatted(.nonLocalizedDecimal))rem")
    }

    @Test("em length unit", arguments: [10, 25, 152])
    func em(pixelAmount: Double) {
        let element = LengthUnit.em(pixelAmount)
        #expect(element.description == "\(pixelAmount.formatted(.nonLocalizedDecimal))em")
    }

    @Test("Percentage length unit", arguments: [10, 25, -67])
    func percentage(percent: Double) {
        let element = LengthUnit.percent(percent)
        #expect(element.description == "\(percent.formatted(.nonLocalizedDecimal))%")
    }

    @Test("vw length unit", arguments: [1, 25, -67])
    func vw(percent: Double) {
        let element = LengthUnit.vw(percent)
        #expect(element.description == "\(percent.formatted(.nonLocalizedDecimal))vw")
    }

    @Test("vh length unit", arguments: [10, 25, -67])
    func vh(percent: Double) {
        let element = LengthUnit.vh(percent)
        #expect(element.description == "\(percent.formatted(.nonLocalizedDecimal))vh")
    }

    @Test("Custom length unit", arguments: ["60vw", "300px", "25%"])
    func custom(unit: String) {
        let element = LengthUnit.custom(unit)
        #expect(element.description == unit)
    }
}
