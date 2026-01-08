//
// Title.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

import Foundation
import Testing

@testable import Raptor

/// Tests for the `title` element.
@Suite("Title Tests")
struct TitleTests {
    @Test("Empty Title", arguments: [""])
    func empty(emptyTitleText: String) {
        withTestRenderingEnvironment {
            let element = Title(emptyTitleText)
            let output = element.markupString()
            #expect(output == "<title>\(emptyTitleText) - My Test Site</title>")
        }
    }

    @Test("Builder", arguments: ["Example Page", "Another Example Page"])
    func builder(titleText: String) {
        withTestRenderingEnvironment {
            let element = Title(titleText)
            let output = element.markupString()
            #expect(output == "<title>\(titleText) - My Test Site</title>")
        }
    }
}
