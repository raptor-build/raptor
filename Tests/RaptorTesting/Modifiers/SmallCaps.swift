//
//  SmallCaps.swift
//  Raptor
//  https://raptor.build
//  See LICENSE for license information.
//

import Foundation
import Testing

@testable import Raptor

/// Tests for the `SmallCaps` modifier.
@Suite("SmallCaps Tests")
struct SmallCapsTests {
    @Test("SmallCaps Modifier")
    func htmlSmallCaps() {
        let element = InlineText("Hello, World!").smallCaps()
        let output = element.markupString()

        #expect(output == "<span style=\"font-variant: small-caps\">Hello, World!</span>")
    }
}
