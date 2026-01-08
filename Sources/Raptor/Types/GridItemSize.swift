//
// GridItemSize.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

/// Describes how an individual column in a grid should size itself.
public struct GridItemSize: Sendable {
    /// The underlying CSS representation of this column size.
    let css: String

    /// A column that sizes itself automatically based on its content.
    public static var automatic: GridItemSize {
        GridItemSize(css: "auto")
    }

    /// A column constrained to an exact, non-flexible width.
    /// - Parameter width: The fixed width of the column.
    /// - Returns: A grid column with a fixed width.
    public static func fixed(_ width: Int) -> GridItemSize {
        GridItemSize(css: "\(width)px")
    }

    /// A column that expands to fill the available remaining space.
    public static var flexible: GridItemSize {
        GridItemSize(css: "1fr")
    }

    /// A flexible column that expands but will not shrink below the specified minimum width.
    /// - Parameter minimum: The minimum allowed width for this column.
    /// - Returns: A flexible column backed by `minmax(minimum, 1fr)`.
    public static func flexible(minimum: Int) -> GridItemSize {
        GridItemSize(css: "minmax(\(minimum)px, 1fr)")
    }

    static func columns(_ count: Int) -> GridItemSize {
        GridItemSize(css: count.formatted())
    }
}
