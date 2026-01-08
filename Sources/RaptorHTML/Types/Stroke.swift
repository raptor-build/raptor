// Stroke.swift
// RaptorHTML
// https://raptor.build
// See LICENSE for license information.
//

/// Represents the shorthand for color, width, and style of a border or outline.
///
/// Equivalent to CSS `border` or `outline`.
public struct Stroke: Sendable, CustomStringConvertible {
    var color: Color
    var width: LengthUnit
    var style: StrokeStyle
    var edges: Edge

    /// Creates a new stroke value.
    /// - Parameters:
    ///   - color: The stroke color.
    ///   - width: The stroke width (default `1px`).
    ///   - style: The stroke style (default `.solid`).
    ///   - edges: The edges the stroke applies to (default `.all`).
    package init(
        _ color: Color,
        width: Double = 1,
        style: StrokeStyle = .solid,
        edges: Edge = .all
    ) {
        self.color = color
        self.width = .px(width)
        self.style = style
        self.edges = edges
    }

    /// The CSS string representation.
    public var description: String {
        "\(width.css) \(style.rawValue) \(color.css)"
    }

    var css: String { description }
}
