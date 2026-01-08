//
// Display.swift
// RaptorHTML
// https://raptor.build
// See LICENSE for license information.
//

/// Defines how an element is displayed in the layout flow.
public enum Display: CustomStringConvertible, Sendable {
    case block, inline, inlineBlock, flex, grid, inlineFlex, inlineGrid, none
    case contents, listItem, table, tableRow, tableCell

    public var description: String {
        switch self {
        case .block: "block"
        case .inline: "inline"
        case .inlineBlock: "inline-block"
        case .flex: "flex"
        case .grid: "grid"
        case .inlineFlex: "inline-flex"
        case .inlineGrid: "inline-grid"
        case .none: "none"
        case .contents: "contents"
        case .listItem: "list-item"
        case .table: "table"
        case .tableRow: "table-row"
        case .tableCell: "table-cell"
        }
    }

    var css: String { description }
}
