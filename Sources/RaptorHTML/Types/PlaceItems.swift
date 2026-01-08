//
// PlaceItems.swift
// RaptorHTML
// https://raptor.build
// See LICENSE for license information.
//

/// Defines both align-items and justify-items in a single declaration.
public struct PlaceItems: Sendable, Hashable {
    /// The vertical alignment behavior.
    let align: AlignItems
    /// The horizontal alignment behavior.
    let justify: AlignItems

    /// The CSS string representation of the combined item placement.
    var css: String { "\(align.css) \(justify.css)" }

    /// Creates a new `PlaceItems` value.
    /// - Parameters:
    ///   - align: The `AlignItems` value for vertical alignment.
    ///   - justify: The `AlignItems` value for horizontal alignment.
    public init(_ align: AlignItems, _ justify: AlignItems) {
        self.align = align
        self.justify = justify
    }
}
