//
// BackgroundOrigin.swift
// RaptorHTML
// https://raptor.build
// See LICENSE for license information.
//

/// Defines the positioning area for a background image relative to an element’s box model.
public enum BackgroundOrigin: CustomStringConvertible, Sendable {
    /// Positions the background relative to the border box.
    case borderBox

    /// Positions the background relative to the padding box. (Default)
    case paddingBox

    /// Positions the background relative to the content box.
    case contentBox

    public var description: String {
        switch self {
        case .borderBox: "border-box"
        case .paddingBox: "padding-box"
        case .contentBox: "content-box"
        }
    }

    var css: String { description }
}
