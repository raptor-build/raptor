//
//  HorizontalAlignment.swift
//  Raptor
//  https://raptor.build
//  See LICENSE for license information.
//

import Foundation
import Testing

@testable import Raptor

/// Tests for the `HorizontalAlignment` modifier.
@Suite("HorizontalAlignment Tests")
struct HorizontalAlignmentTests {
    private static let zippedAlignment = zip(
        [HorizontalAlignment.leading, .center, .trailing],
        ["margin-inline-end: auto",
         "margin-inline: auto",
         "margin-inline-start: auto"])

    @Test("Text", arguments: zippedAlignment)
    func allAlignmentsForText(alignment: HorizontalAlignment, expectedStyle: String) {
        let element = Text("Hello world!").horizontalAlignment(alignment)
        let output = element.markupString()

        #expect(output == #"<p style="\#(expectedStyle)">Hello world!</p>"#)
    }

    @Test("Column", arguments: zippedAlignment)
    func allAlignmentsForColumn(alignment: HorizontalAlignment, expectedStyle: String) {
        let element = TableColumn {
            ControlLabel("Left Label")
            ControlLabel("Right Label")
        }
        .horizontalAlignment(alignment)

        let output = element.markupString()

        #expect(output == """
        <td colspan="1" style="\(expectedStyle); vertical-align: top">\
        <label>Left Label</label>\
        <label>Right Label</label>\
        </td>
        """)    }
}
