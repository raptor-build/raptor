//
//  Underline.swift
//  Raptor
//  https://raptor.build
//  See LICENSE for license information.
//

import Foundation
import Testing

@testable import Raptor

/// Tests for the `Underline` element.
@Suite("Underline Tests")
struct UnderlineTests {
    @Test("Single Element Test", arguments: ["This is a test", "Another test", ""])
    func singleElement(underlineText: String) {
        withTestRenderingEnvironment {
            let element = Underline(underlineText)
            let output = element.markupString()
            #expect(output == "<u>\(underlineText)</u>")
        }
    }

    @Test("Builder", arguments: ["This is a test", "Another test", ""])
    func builder(underlineText: String) {
        withTestRenderingEnvironment {
            let element = Underline { underlineText }
            let output = element.markupString()
            #expect(output == "<u>\(underlineText)</u>")
        }
    }
}
