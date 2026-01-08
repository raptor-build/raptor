//
// TableRowSeparatorModifier.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

public extension HTML {
    /// Controls whether this table displays row separators.
    /// - Parameter visibility: The visibility to apply to row separators.
    /// - Returns: A modified table with updated separator visibility.
    func tableRowSeparator(_ visibility: Visibility) -> some HTML {
        self.data("table-separators", visibility == .visible ? "true" : "false")
    }
}

public extension InlineContent {
    /// Controls whether this table displays row separators.
    /// - Parameter visibility: The visibility to apply to row separators.
    /// - Returns: A modified table with updated separator visibility.
    func tableRowSeparator(_ visibility: Visibility) -> some InlineContent {
        self.data("table-separators", visibility == .visible ? "true" : "false")
    }
}
