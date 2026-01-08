//
//  Hidden.swift
//  Raptor
//  https://raptor.build
//  See LICENSE for license information.
//

import Foundation
import Testing

@testable import Raptor

/// Tests for the `Hidden` modifier.
@Suite("Hidden Tests")
struct HiddenTests {
    @Test("Hidden Modifier for Text")
    func hiddenForText() {
        let element = Text("Hello world!").hidden()
        let output = element.markupString()

        #expect(output == #"<p class="d-none">Hello world!</p>"#)
    }

    @Test("Hidden Modifier for Column")
    func hiddenForColumn() {
        let element = TableColumn {
            ControlLabel("Left Label")
            ControlLabel("Right Label")
        }.hidden()
        let output = element.markupString()

        #expect(output == """
        <td colspan="1" class="d-none" style="vertical-align: top">\
        <label>Left Label</label>\
        <label>Right Label</label>\
        </td>
        """)
    }
}
