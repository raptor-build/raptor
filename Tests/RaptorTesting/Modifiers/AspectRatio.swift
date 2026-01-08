//
//  AspectRatio.swift
//  Raptor
//  https://raptor.build
//  See LICENSE for license information.
//

import Foundation
import Testing

@testable import Raptor

/// Tests for the `AspectRatio` modifier.
@Suite("AspectRatio Tests")
struct AspectRatioTests {
    private let formatter: NumberFormatter = {
        var formatter = NumberFormatter()
        formatter.minimumFractionDigits = 0 // allow no decimals
        formatter.maximumFractionDigits = 3 // limit to 3 decimals
        formatter.numberStyle = .decimal
        return formatter
    }()

    @Test("Verify AspectRatio Modifiers", arguments: AspectRatio.allCases)
    func verifyAspectRatioModifiers(ratio: AspectRatio) {
        let element = Text("Hello").aspectRatio(ratio)
        let output = element.markupString()
        let ratioString = formatter.string(from: NSNumber(value: ratio.numericValue))!
        #expect(output == "<p style=\"aspect-ratio: \(ratioString)\">Hello</p>")
    }

    @Test("Verify Content Modes", arguments: AspectRatio.allCases, ContentMode.allCases)
    func verifyContentModes(ratio: AspectRatio, mode: ContentMode) {
        let element = Image("/images/example.jpg").aspectRatio(ratio, contentMode: mode)
        let output = withTestRenderingEnvironment {
            element.markupString()
        }
        let ratioString = formatter.string(from: NSNumber(value: ratio.numericValue))!

        #expect(output == """
        <div style="aspect-ratio: \(ratioString)">\
        <img src="/images/example.jpg" alt="" class="\(mode.cssClass)" /></div>
        """)
    }
}
