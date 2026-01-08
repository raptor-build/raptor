//
//  Section.swift
//  Raptor
//  https://raptor.build
//  See LICENSE for license information.
//

import Foundation
import Testing

@testable import Raptor

/// Tests for the `Section` element.
@Suite("Section Tests")
struct SectionTests {
    @Test("Section")
    func section() {
        let element = Section {
            InlineText("Hello, World!")
            InlineText("Goodbye, World!")
        }

        let output = element.markupString()
        #expect(output == "<div><span>Hello, World!</span><span>Goodbye, World!</span></div>")
    }

    @Test("Section with Header")
    func sectionWithHeader() {
        let element = Section("Greetings") {
            InlineText("Hello, World!")
            InlineText("Goodbye, World!")
        }
        .headerProminence(.title3)

        let output = element.markupString()

        #expect(output == """
        <section>\
        <h3>Greetings</h3>\
        <span>Hello, World!</span>\
        <span>Goodbye, World!</span>\
        </section>
        """)
    }
}
