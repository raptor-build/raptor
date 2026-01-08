//
//  HStack.swift
//  Raptor
//  https://raptor.build
//  See LICENSE for license information.
//

import Foundation
import Testing

@testable import Raptor

/// Tests for the `HStack` element.
@Suite("HStack Tests")
struct HStackTests {
    @Test("HStack with elements")
    func basicHStack() {
        let element = HStack(alignment: .top) {
            ControlLabel("Top Label")
            ControlLabel("Bottom Label")
        }
        let output = element.markupString()

        #expect(output == """
        <div class="hstack gap-3">\
        <label class="align-self-start">Top Label</label>\
        <label class="align-self-start">Bottom Label</label>\
        </div>
        """)
    }

    @Test("HStack with elements and spacing")
    func elementsWithSpacingWithinHStack() {
        let element = HStack(spacing: 10) {
            ControlLabel("Top Label")
            ControlLabel("Bottom Label")
        }
        let output = element.markupString()

        #expect(output == """
        <div class="hstack" style="gap: 10px">\
        <label class="align-self-center">Top Label</label>\
        <label class="align-self-center">Bottom Label</label>\
        </div>
        """)
    }
}
