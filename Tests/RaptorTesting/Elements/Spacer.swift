//
//  Spacer.swift
//  Raptor
//  https://raptor.build
//  See LICENSE for license information.
//

import Foundation
import Testing

@testable import Raptor

/// Tests for the `Spacer` element.
@Suite("Spacer Tests")
struct SpacerTests {
    @Test("SpacerTest")
    func basicSpacerTest() {
        let element = Spacer()
        let output = element.markupString()

        #expect(output == "<div class=\"mt-auto spacer\"></div>")
    }
}
