//
// GridTemplateColumns.swift
// RaptorHTML
// https://raptor.build
// See LICENSE for license information.
//

/// Defines the column structure of a CSS grid layout.
public struct GridTemplateColumns: Sendable, Hashable {
    /// The CSS string representation of the grid template columns.
    let css: String

    /// Repeats a column pattern a fixed number of times.
    /// - Parameters:
    ///   - count: The number of columns to repeat.
    ///   - size: The size of each repeated column.
    /// - Returns: A `GridTemplateColumns` value using a `repeat()` pattern.
    public static func repeatPattern(_ count: Int, _ size: LengthUnit) -> Self {
        .init(css: "repeat(\(count), \(size.css))")
    }

    /// Automatically fits as many columns as possible within the container.
    /// - Parameter size: The size constraint for each column.
    /// - Returns: A `GridTemplateColumns` value using `auto-fit`.
    public static func autoFit(_ size: LengthUnit) -> Self {
        .init(css: "repeat(auto-fit, \(size.css))")
    }

    /// Defines a custom grid template column definition.
    /// - Parameter css: A custom CSS string for complex grid configurations.
    /// - Returns: A `GridTemplateColumns` value with the provided CSS.
    public static func custom(_ css: String) -> Self {
        .init(css: css)
    }
}
