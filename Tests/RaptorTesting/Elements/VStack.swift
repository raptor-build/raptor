//
//  VStack.swift
//  Raptor
//  https://raptor.build
//  See LICENSE for license information.
//

import Foundation
import Testing

@testable import Raptor

/// Tests for the `VStack` element.
@Suite("VStack Tests")
struct VStackTests {
    @Test("VStack with elements")
    func basicVStack() {
        let element = VStack {
            ControlLabel("Top Label")
            ControlLabel("Bottom Label")
        }
        let output = element.markupString()

        #expect(output == """
        <div class="vstack gap-3">\
        <label class="align-self-center">Top Label</label>\
        <label class="align-self-center">Bottom Label</label>\
        </div>
        """)
    }

    @Test("VStack with elements and spacing")
    func elementsWithSpacingWithinVStack() {
        let element = VStack(spacing: 10) {
            ControlLabel("Top Label")
            ControlLabel("Bottom Label")
        }
        let output = element.markupString()

        #expect(output == """
        <div class="vstack" style="gap: 10px">\
        <label class="align-self-center">Top Label</label>\
        <label class="align-self-center">Bottom Label</label>\
        </div>
        """)
    }
}
