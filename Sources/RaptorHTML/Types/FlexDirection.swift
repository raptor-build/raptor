//
// Flex.swift
// RaptorHTML
// https://raptor.build
// See LICENSE for license information.
//

/// Defines the direction in which flex items are placed within a flex container.
public enum FlexDirection: String, Sendable, Hashable, CaseIterable {
    /// Items are placed in the same direction as the text (left to right).
    case row
    /// Items are placed in the reverse direction of the text (right to left).
    case rowReverse = "row-reverse"
    /// Items are placed from top to bottom.
    case column
    /// Items are placed from bottom to top.
    case columnReverse = "column-reverse"

    /// The CSS string representation of the direction.
    var css: String { rawValue }
}
