//
// TextAlign.swift
// RaptorHTML
// https://raptor.build
// See LICENSE for license information.
//

/// Specifies the horizontal alignment of inline text content.
public enum TextAlign: String, Sendable, Hashable {
    case start
    case end
    case left
    case right
    case center
    case justify
    case matchParent = "match-parent"

    var css: String { rawValue }
}
