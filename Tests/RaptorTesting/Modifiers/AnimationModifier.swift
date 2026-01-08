//
//  AnimationModifier.swift
//  Raptor
//  https://raptor.build
//  See LICENSE for license information.
//

import Foundation
import Testing

@testable import Raptor

/// Tests for the `AnimationModifier` modifier.
@Suite("AnimationModifier Tests")
struct AnimationModifierTests {
    @Test("HTML Animation")
    func htmlAnimationModifier() {
        let element = Text {
            InlineText("This is a Span")
        }.animation(.automatic)

        let output = element.markupString()
        print(output)

        // Example output:
        // <p style="--anim-duration: 0.2s; --anim-easing: cubic-bezier(0.4, 1.0, 0.0, 1.0)">
        //   <span>This is a Span</span>
        // </p>
        let pattern = #"""
        <p style="--anim-duration: [0-9.]+s; --anim-easing: cubic-bezier\([0-9., ]+\)">\
        <span>This is a Span</span>\
        </p>
        """#
        .replacingOccurrences(of: "\n", with: "")

        do {
            let regex = try Regex(pattern)

            if output.firstMatch(of: regex) == nil {
                Issue.record("Output does not match the expected animation pattern.\nOutput was:\n\(output)")
            }
        } catch {
            // Record an issue to fail the test with a descriptive message
            Issue.record("Failed to create regular expression: \(error)")
        }
    }
}
