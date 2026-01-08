//
// GridTrack.swift
// RaptorHTML
// https://raptor.build
// See LICENSE for license information.
//

/// Defines a grid track pattern for rows or columns.
public struct GridTrack: Sendable, Hashable {
    /// The CSS string representation of the grid track.
    let css: String

    /// Creates a custom grid track definition.
    /// - Parameter css: A custom CSS string (e.g. `"1fr 2fr min-content"`).
    public init(_ css: String) { self.css = css }

    /// Repeats a track pattern a fixed number of times.
    /// - Parameters:
    ///   - count: The number of repetitions.
    ///   - size: The size of each repeated track.
    /// - Returns: A `GridTrack` using a `repeat()` pattern.
    public static func repeatPattern(_ count: Int, _ size: LengthUnit) -> Self {
        .init("repeat(\(count), \(size.css))")
    }

    /// Automatically fits as many tracks as possible within the container.
    /// - Parameter size: The size constraint for each track.
    /// - Returns: A `GridTrack` using the `auto-fit` pattern.
    public static func autoFit(_ size: LengthUnit) -> Self {
        .init("repeat(auto-fit, \(size.css))")
    }

    /// Automatically fills the grid with as many tracks as possible.
    /// - Parameter size: The size constraint for each track.
    /// - Returns: A `GridTrack` using the `auto-fill` pattern.
    public static func autoFill(_ size: LengthUnit) -> Self {
        .init("repeat(auto-fill, \(size.css))")
    }

    /// Defines a custom track template.
    /// - Parameter css: A custom CSS string (e.g. `"1fr 2fr min-content"`).
    /// - Returns: A `GridTrack` with the specified CSS.
    public static func custom(_ css: String) -> Self {
        .init(css)
    }
}
