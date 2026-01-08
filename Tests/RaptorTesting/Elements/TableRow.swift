//
//  TableRow.swift
//  Raptor
//  https://raptor.build
//  See LICENSE for license information.
//

import Foundation
import Testing

@testable import Raptor

/// Tests for the `TableRow` element.
@Suite("TableRow Tests")
struct TableRowTests {
    @Test("TableRow with Multiple Columns")
    func rowWithMultipleColumns() {
        let row = TableRow {
            Text("Column 1")
            Text("Column 2")
        }
        let output = row.render().string

        #expect(output == "<tr><td><p>Column 1</p></td><td><p>Column 2</p></td></tr>")
    }

    @Test("TableRow with Column Elements")
    func rowWithColumnElements() {
        let row = TableRow {
            TableColumn { Text("Column 1") }
            TableColumn { Text("Column 2") }
        }
        let output = row.render().string

        #expect(output == """
        <tr>\
        <td colspan="1" style="vertical-align: top">\
        <p>Column 1</p>\
        </td>\
        <td colspan="1" style="vertical-align: top">\
        <p>Column 2</p>\
        </td>\
        </tr>
        """)
    }

    @Test("TableRow with Mixed Content")
    func rowWithMixedContent() {
        let row = TableRow {
            Text("Column 1")
            TableColumn { Text("Column 2") }
        }
        let output = row.render().string

        #expect(output == """
        <tr>\
        <td>\
        <p>Column 1</p>\
        </td>\
        <td colspan="1" style="vertical-align: top">\
        <p>Column 2</p>\
        </td>\
        </tr>
        """)
    }
}
