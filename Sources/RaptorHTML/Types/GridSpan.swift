//
// GridSpan.swift
// RaptorHTML
// https://raptor.build
// See LICENSE for license information.
//

/// Defines the start and end grid lines for a grid item span.
public struct GridSpan: Sendable, Hashable {
    /// The starting grid line (optional).
    let start: GridLine?
    /// The ending grid line (optional).
    let end: GridLine?

    /// The CSS string representation of the grid span.
    var css: String {
        switch (start, end) {
        case let (start?, end?): "\(start.css) / \(end.css)"
        case let (start?, nil): "\(start.css)"
        case let (nil, end?): "auto / \(end.css)"
        default: "auto"
        }
    }

    /// Creates a grid span with optional start and end lines.
    /// - Parameters:
    ///   - start: The starting grid line, or `nil` for automatic placement.
    ///   - end: The ending grid line, or `nil` for automatic placement.
    /// - Returns: A `GridSpan` defining the item's span across the grid.
    init(_ start: GridLine?, _ end: GridLine?) {
        self.start = start
        self.end = end
    }

    /// Creates a span between two grid lines.
    ///
    /// Equivalent CSS:
    /// ```css
    /// grid-column: 1 / 3;
    /// ```
    public static func lines(_ start: GridLine?, _ end: GridLine?) -> Self {
        .init(start, end)
    }

    /// Creates a span covering a specific number of tracks.
    ///
    /// Equivalent CSS:
    /// ```css
    /// grid-row: span 2;
    /// ```
    public static func span(_ count: Int) -> Self {
        .init(.span(count), nil)
    }
}
