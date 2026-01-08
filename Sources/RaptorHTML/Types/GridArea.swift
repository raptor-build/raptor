//
// GridArea.swift
// RaptorHTML
// https://raptor.build
// See LICENSE for license information.
//

/// Defines a named or coordinate-based grid area within a CSS Grid layout.
public struct GridArea: Sendable {
    /// Represents how the grid area is defined — by name or by line coordinates.
    public enum Kind: Sendable {
        /// A named grid area (e.g. `"header"`).
        case name(String)
        /// A grid area defined by start and optional end line numbers.
        case lines(
            rowStart: Int?,
            columnStart: Int?,
            rowEnd: Int?,
            columnEnd: Int?
        )
    }

    let kind: Kind

    /// The CSS string representation of the grid area.
    var css: String {
        switch kind {
        case .name(let name):
            return name
        case .lines(let row1, let column1, let row2, let column2):
            func line(_ value: Int?) -> String { value.map(String.init) ?? "auto" }
            return "\(line(row1)) / \(line(column1)) / \(line(row2)) / \(line(column2))"
        }
    }

    /// Creates a grid area by name.
    public static func named(_ name: String) -> Self {
        .init(kind: .name(name))
    }

    /// Creates a grid area using explicit grid line positions.
    /// - Parameters:
    ///   - rowStart: The starting row line number.
    ///   - columnStart: The starting column line number.
    ///   - rowEnd: The ending row line (optional, defaults to `"auto"`).
    ///   - columnEnd: The ending column line (optional, defaults to `"auto"`).
    /// - Returns: A `GridArea` defined by line coordinates.
    public static func lines(
        rowStart: Int?,
        columnStart: Int?,
        rowEnd: Int? = nil,
        columnEnd: Int? = nil
    ) -> Self {
        .init(kind: .lines(
            rowStart: rowStart,
            columnStart: columnStart,
            rowEnd: rowEnd,
            columnEnd: columnEnd
        ))
    }
}
