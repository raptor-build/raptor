//
// MediaQuery.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

import Foundation
import Testing

@testable import Raptor

/// Tests for the `Margin` modifier.
@Suite("MediaQuery Tests")
struct MediaQueryTests {
    @Test("Contrast queries", arguments: zip(
        ContrastLevel.allCases,
        ["prefers-contrast: no-preference",
         "prefers-contrast: more",
         "prefers-contrast: less"]))
    func contrast_queries_render_correctly(query: ContrastLevel, css: String) {
        let output = query.condition
        #expect(output == css)
    }

    @Test("Display mode queries", arguments: zip(
        DisplayMode.allCases,
        ["display-mode: browser",
         "display-mode: fullscreen",
         "display-mode: minimal-ui",
         "display-mode: picture-in-picture",
         "display-mode: standalone",
         "display-mode: window-controls-overlay"]))
    func display_mode_queries_render_correctly(query: DisplayMode, css: String) {
        let output = query.condition
        #expect(output == css)
    }

    @Test("Orientation queries", arguments: zip(
        Orientation.allCases,
        ["orientation: portrait", "orientation: landscape"]))
    func orientation_queries_render_correctly(query: Orientation, css: String) {
        let output = query.condition
        #expect(output == css)
    }

    @Test("Transparency queries", arguments: zip(
        TransparencyLevel.allCases,
        ["prefers-reduced-transparency: reduce", "prefers-reduced-transparency: no-preference"]))
    func transparency_queries_render_correctly(query: TransparencyLevel, css: String) {
        let output = query.condition
        #expect(output == css)
    }

    @Test("Reduced motion queries", arguments: zip(
        MotionProminence.allCases,
        ["prefers-reduced-motion: reduce", "prefers-reduced-motion: no-preference"]))
    func reduced_motion_queries_render_correctly(query: MotionProminence, css: String) {
        let output = query.condition
        #expect(output == css)
    }
}
