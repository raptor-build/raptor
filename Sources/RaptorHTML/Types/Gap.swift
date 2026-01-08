//
// Gap.swift
// RaptorHTML
// https://raptor.build
// See LICENSE for license information.
//

/// Represents the spacing (gutter) between adjacent **tracks**—rows and columns—
/// in a CSS Grid or Flexbox container.
///
/// In CSS, the `gap` shorthand sets both `row-gap` and `column-gap`.
/// When one value is provided, it applies to both directions;
/// when two are provided, the first applies to row tracks, the second to column tracks.
///
/// Example CSS equivalents:
/// ```css
/// gap: 1rem;        /* uniform spacing */
/// gap: 1rem 2rem;   /* 1rem row-gap, 2rem column-gap */
/// ```
public struct Gap: Sendable, Hashable {
    /// Defines the possible forms of a gap value.
    public enum Value: Sendable, Hashable {
        /// A fixed or relative length (e.g. `.px(8)`, `.rem(1)`).
        case length(LengthUnit)
        /// The CSS keyword `normal`, representing the default spacing behavior.
        case normal

        var css: String {
            switch self {
            case .length(let value): value.css
            case .normal: "normal"
            }
        }
    }

    private let row: Value?
    private let column: Value?

    /// Creates a new `Gap` instance with optional distinct row and column values.
    /// - Parameters:
    ///   - row: The spacing between row tracks (`nil` means browser default).
    ///   - column: The spacing between column tracks (`nil` means browser default).
    private init(row: Value?, column: Value? = nil) {
        self.row = row
        self.column = column
    }

    /// The CSS string representation.
    var css: String {
        switch (row, column) {
        case let (.some(row), .some(column)):
            "\(row.css) \(column.css)"
        case let (.some(row), .none):
            row.css
        case let (.none, .some(column)):
            // If only a column gap is provided, apply it uniformly.
            column.css
        case (.none, .none):
            "normal"
        }
    }

    /// Creates a uniform gap for both row and column tracks.
    /// - Parameter value: The gap size as a `LengthUnit`.
    /// - Returns: A `Gap` applying the same spacing in both directions.
    ///
    /// Equivalent CSS:
    /// ```css
    /// gap: 1rem;
    /// ```
    public static func all(_ value: LengthUnit) -> Self {
        .init(row: .length(value))
    }

    /// Creates distinct gaps between row and column tracks.
    /// - Parameters:
    ///   - row: The row-track gap size (`nil` means default).
    ///   - column: The column-track gap size (`nil` means default).
    /// - Returns: A `Gap` with independent row and column spacing.
    ///
    /// Equivalent CSS:
    /// ```css
    /// gap: 1rem 2rem;
    /// ```
    public static func tracks(row: LengthUnit? = nil, column: LengthUnit? = nil) -> Self {
        .init(
            row: row.map { .length($0) },
            column: column.map { .length($0) }
        )
    }

    /// The keyword `normal`, representing the browser’s default track spacing.
    ///
    /// Equivalent CSS:
    /// ```css
    /// gap: normal;
    /// ```
    public static let normal = Gap(row: .normal)
}
