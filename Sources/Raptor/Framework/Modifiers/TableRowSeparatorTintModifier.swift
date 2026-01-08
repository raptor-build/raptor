//
// TableRowSeparatorTintModifier.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

public extension HTML {
    /// Sets the tint color used for this table’s row separators.
    /// - Parameter color: The color to apply to separator lines.
    /// - Returns: A modified table with the updated separator tint.
    func tableRowSeparatorTint(_ color: Color) -> some HTML {
        self.style(.variable("table-separator-color", value: color.description))
    }
}

public extension InlineContent {
    /// Sets the tint color used for this table’s row separators.
    /// - Parameter color: The color to apply to separator lines.
    /// - Returns: A modified table with the updated separator tint.
    func tableRowSeparatorTint(_ color: Color) -> some InlineContent {
        self.style(.variable("table-separator-color", value: color.description))
    }
}
