//
//  Angle.swift
//  Raptor
//  https://raptor.build
//  See LICENSE for license information.
//

import Foundation
import Testing

@testable import Raptor

/// Tests for the `Angle` type.
@Suite("Angle Tests")
struct AngleTests {
    @Test("Degrees")
    func degreesTest() {
        let angle = Angle.degrees(180)
        let output = angle.value
        #expect(output == "180.0deg")
    }

    @Test("Radians")
    func radiansTest() {
        let angle = Angle.radians(.pi)
        let output = angle.value
        #expect(output == "\(Double.pi)rad")
    }

    @Test("Turns")
    func turnsTest() {
        let angle = Angle.turns(0.5)
        let output = angle.value
        #expect(output == "0.5turn")
    }
}
