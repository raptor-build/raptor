//
// GridLine.swift
// RaptorHTML
// https://raptor.build
// See LICENSE for license information.
//

/// Represents a grid line reference used in grid positioning.
public struct GridLine: Sendable, Hashable {
    /// The underlying CSS string value for the grid line.
    let value: String

    /// The CSS string representation of the grid line.
    var css: String { value }

    /// Creates a grid line reference by index.
    /// - Parameter index: The line number to position the item on.
    /// - Returns: A `GridLine` referencing the specified line.
    public static func line(_ index: Int) -> Self {
        .init(value: "\(index)")
    }

    /// Creates a span that covers multiple grid tracks.
    /// - Parameter count: The number of tracks to span.
    /// - Returns: A `GridLine` spanning the specified number of tracks.
    public static func span(_ count: Int) -> Self {
        .init(value: "span \(count)")
    }

    /// Automatically positions the grid item according to the grid flow.
    public static let auto = Self(value: "auto")
}
