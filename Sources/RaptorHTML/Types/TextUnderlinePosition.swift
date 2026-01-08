//
// TextUnderlinePosition.swift
// RaptorHTML
// https://raptor.build
// See LICENSE for license information.
//

/// Specifies the position of the underline decoration.
public enum TextUnderlinePosition: String, Sendable, Hashable {
    case auto
    case under
    case left
    case right

    var css: String { rawValue }
}
