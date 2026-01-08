//
// PlaceContent.swift
// RaptorHTML
// https://raptor.build
// See LICENSE for license information.
//

/// Defines both align-content and justify-content in a single declaration.
public struct PlaceContent: Sendable, Hashable {
    /// The vertical alignment behavior.
    let align: AlignContent
    /// The horizontal alignment behavior.
    let justify: JustifyContent

    /// The CSS string representation of the combined content placement.
    var css: String { "\(align.css) \(justify.css)" }

    /// Creates a new `PlaceContent` value.
    /// - Parameters:
    ///   - align: The `AlignContent` value for vertical alignment.
    ///   - justify: The `JustifyContent` value for horizontal alignment.
    public init(_ align: AlignContent, _ justify: JustifyContent) {
        self.align = align
        self.justify = justify
    }
}
