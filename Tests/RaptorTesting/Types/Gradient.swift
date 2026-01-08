//
//  Gradient.swift
//  Raptor
//  https://raptor.build
//  See LICENSE for license information.
//

import Foundation
import Testing

@testable import Raptor

/// Tests for the `Gradient` type.
@Suite("Gradient Tests")
struct GradientTests {
    @Test("linearGradient", arguments: zip(
        [UnitPoint.top, .bottomLeading, .leading],
        [UnitPoint.bottom, .topTrailing, .trailing]))
    func linearGradient(start: UnitPoint, end: UnitPoint) {
        let element = Gradient.linearGradient(colors: .red, .blue, from: start, to: end)
        let angle = Int(start.degrees(to: end))
        let output = element.description

        #expect(output == """
        linear-gradient(\(angle)deg, var(--r-red) 0.0%, var(--r-blue) 100.0%)
        """)
    }

    @Test("radialGradient")
    func radialGradient() {
        let element = Gradient.radialGradient(colors: .red, .blue)
        let output = element.description

        #expect(output == """
        radial-gradient(circle at center, var(--r-red) 0.0%, var(--r-blue) 100.0%)
        """)
    }

    @Test("conicGradient should default to 0deg")
    func conicGradient() {
        let element = Gradient.conicGradient(colors: .red, .blue)
        let output = element.description

        #expect(output == """
        conic-gradient(from 0deg at center, var(--r-red) 0.0%, var(--r-blue) 100.0%)
        """)
    }

    @Test("conicGradient should use correct angles", arguments: [45, 90, 180])
    func conicGradient(angle: Int) {
        let element = Gradient.conicGradient(colors: .red, .blue, angle: angle)
        let output = element.description

        #expect(output == """
        conic-gradient(from \(angle)deg at center, var(--r-red) 0.0%, var(--r-blue) 100.0%)
        """)
    }
}
