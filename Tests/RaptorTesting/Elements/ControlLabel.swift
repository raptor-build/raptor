//
// ControlLabel.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

import Foundation
import Testing

@testable import Raptor

/// Tests for the `ControlLabel` element.
@Suite("ControlLabel Tests")
struct ControlLabelTests {
    @Test("Basic Label")
    func basicLabel() {
        let element = ControlLabel("This is a text for label")
        let output = element.markupString()

        #expect(output == "<label>This is a text for label</label>")
    }
}
