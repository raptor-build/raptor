//
//  Column.swift
//  Raptor
//  https://raptor.build
//  See LICENSE for license information.
//

import Foundation
import Testing

@testable import Raptor

/// Tests for the `Column` element.
@Suite("Column Tests")
struct ColumnTests {
    private static let columnSpans: [Int] = [0, 1, 10, 100]

    @Test("Column with items")
    func basicColumn() {
        let element = TableColumn {
            ControlLabel("Left Label")
            ControlLabel("Middle Label")
            ControlLabel("Right Label")
        }

        let output = element.markupString()

        #expect(output == """
        <td colspan="1" style="vertical-align: top">\
        <label>Left Label</label>\
        <label>Middle Label</label>\
        <label>Right Label</label>\
        </td>
        """)
    }

    @Test("Column with columnSpan", arguments: Self.columnSpans)
    func columnWithColumnSpan(columnSpan: Int) {
        let element = TableColumn {
            ControlLabel("Left Label")
            ControlLabel("Middle Label")
            ControlLabel("Right Label")
        }.tableCellColumns(columnSpan)

        let output = element.markupString()

        #expect(output == """
        <td colspan="\(columnSpan)" style="vertical-align: top">\
        <label>Left Label</label>\
        <label>Middle Label</label>\
        <label>Right Label</label>\
        </td>
        """)
    }

    @Test("Column with vertical alignment", arguments: Alignment.allCases)
    func columnWithVerticalAlignment(alignment: Alignment) {
        let element = TableColumn {
            ControlLabel("Left Label")
            ControlLabel("Middle Label")
            ControlLabel("Right Label")
        }
        .alignment(alignment)

        let output = element.markupString()
        let alignmentStyles = alignment.tableCellAlignmentRules.map(\.description).joined(separator: "; ")

        #expect(output == """
        <td colspan="1" style="\(alignmentStyles)">\
        <label>Left Label</label>\
        <label>Middle Label</label>\
        <label>Right Label</label>\
        </td>
        """)
    }
}
