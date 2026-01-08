//
//  Abbreviation.swift
//  Raptor
//  https://raptor.build
//  See LICENSE for license information.
//

import Foundation
import Testing

@testable import Raptor

/// Tests for the `Abbreviation` element.
@Suite("Abbreviation Tests")
struct AbbreviationTests {
    @Test("Basic Abbreviation", arguments: ["abbr"], ["abbreviation"])
    func basic(abbreviation: String, description: String) {
        let element = Abbreviation(abbreviation, description: description)
        let output = element.markupString()

        #expect(output == "<abbr title=\"\(description)\">\(abbreviation)</abbr>")
    }

    @Test("Single Element Abbreviation", arguments: ["abbreviation"], ["abbr"])
    func singleElement(description: String, abbreviation: String) {
        let element = Abbreviation(description) { InlineText(abbreviation) }
        let output = element.markupString()

        #expect(output == """
        <abbr title=\"\(description)\">\
        <span>\(abbreviation)</span>\
        </abbr>
        """)
    }

    @Test("Builder Abbreviation", arguments: ["abbreviation"], ["abbr"])
    func builder(description: String, abbreviation: String) {
        let element = Abbreviation(description) {
            InlineText {
                abbreviation
            }
        }

        let output = element.markupString()

        #expect(output == """
        <abbr title=\"\(description)\">\
        <span>\(abbreviation)</span>\
        </abbr>
        """)
    }
}
