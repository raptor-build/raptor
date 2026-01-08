//
// BoxSizing.swift
// RaptorHTML
// https://raptor.build
// See LICENSE for license information.
//

/// Defines which box model is used for an element’s width and height.
public enum BoxSizing: CustomStringConvertible, Sendable {
    case contentBox, borderBox

    public var description: String {
        switch self {
        case .contentBox: "content-box"
        case .borderBox: "border-box"
        }
    }

    var css: String { description }
}
