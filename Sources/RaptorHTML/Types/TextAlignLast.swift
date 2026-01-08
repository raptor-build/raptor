//
// TextAlignLast.swift
// RaptorHTML
// https://raptor.build
// See LICENSE for license information.
//

/// Defines the alignment of the last line in a block of justified text.
public enum TextAlignLast: String, Sendable, Hashable {
    case auto
    case start
    case end
    case left
    case right
    case center
    case justify

    var css: String { rawValue }
}
