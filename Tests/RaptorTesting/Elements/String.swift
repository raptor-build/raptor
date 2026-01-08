//
// String.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

import Foundation
import Testing

@testable import Raptor

/// Tests for Strings (aka Plain Text)
@Suite("String Tests")
struct StringTests {
    @Test("Single Element", arguments: ["This is a test", ""])
    func singleElement(element: String) {
        let element = element
        let output = element.markupString()

        #expect(output == element)
    }
}
