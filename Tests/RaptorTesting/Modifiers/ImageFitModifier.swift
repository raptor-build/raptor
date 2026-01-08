//
// ImageFitModifier.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

import Foundation
import Testing
@testable import Raptor

/// Tests for the `ImageFitModifier` modifier.
@Suite("ImageFitModifier Tests")
struct ImageFitModifierTests {
    @Test("Default parameters")
    func testDefaultParameters() {
        let image = Image("/images/example-image.jpg")
        let modifiedImage = image.imageFit()
        let output = withTestRenderingEnvironment {
            modifiedImage.markupString()
        }

        #expect(output.contains("class=\"w-100 h-100 object-fit-cover\""))
        #expect(output.contains("object-position: 50% 50%"))
    }

    @Test("Custom fit and anchor parameters")
    func testCustomParameters() {
        let image = Image("/images/example-image.jpg")
        let modifiedImage = image.imageFit(.fit, anchor: .bottomLeading)
        let output = withTestRenderingEnvironment {
            modifiedImage.markupString()
        }

        #expect(output.contains("class=\"w-100 h-100 object-fit-contain\""))
        #expect(output.contains("object-position: 0% 100%"))
    }

    @Test("Different anchor points", arguments: [UnitPoint.topLeading, .bottomTrailing])
    func testDifferentAnchorPoints(anchor: UnitPoint) {
        let image = Image("/images/example-image.jpg")
        let modifiedImage = image.imageFit(anchor: anchor)
        let output = withTestRenderingEnvironment {
            modifiedImage.markupString()
        }
        #expect(output.contains("object-position: \(anchor.xPercentValue) \(anchor.yPercentValue)"))
    }
}
