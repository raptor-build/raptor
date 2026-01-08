//
//  Badge.swift
//  Raptor
//  https://raptor.build
//  See LICENSE for license information.
//

import Foundation
import Testing

@testable import Raptor

/// Tests for the `Badge` element.
@Suite("Badge Tests")
struct BadgeTests {
    @Test("Badge", arguments: BadgeStyle.allCases)
    func badge(style: BadgeStyle) {
        let element = Text {
            Badge("Some text")
                .badgeStyle(style)
        }

        let output = element.markupString()
        #expect(output == "<p><span class=\"badge badge-\(style.rawValue) badge-pill\">Some text</span></p>")
    }
}
