//
// ColumnRule.swift
// RaptorHTML
// https://raptor.build
// See LICENSE for license information.
//

/// Shorthand for defining column-rule-width, column-rule-style, and column-rule-color.
public struct ColumnRule: CustomStringConvertible, Sendable {
    var width: LengthUnit?
    var style: StrokeStyle?
    var color: Color?

    init(width: LengthUnit? = nil, style: StrokeStyle? = nil, color: Color? = nil) {
        self.width = width
        self.style = style
        self.color = color
    }

    public var description: String {
        [width?.description, style?.rawValue, color?.description]
            .compactMap { $0 }
            .joined(separator: " ")
    }
}
