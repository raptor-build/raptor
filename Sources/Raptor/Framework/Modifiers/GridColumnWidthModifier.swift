//
// GridColumnWidthModifier.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

public extension HTML {
    /// Adjusts the number of columns assigned to this element.
    /// - Parameter width: The new number of columns to use.
    /// - Returns: A new element with the adjusted column width.
    func gridCellColumns(_ width: Int) -> some HTML {
        GridItem<Self>(content: self, columnSpan: width)
    }
}

public extension InlineContent {
    /// Adjusts the number of columns assigned to this element.
    /// - Parameter width: The new number of columns to use.
    /// - Returns: A new element with the adjusted column width.
    func gridCellColumns(_ width: Int) -> some InlineContent {
        GridItem<Self>(content: self, columnSpan: width)
    }
}
