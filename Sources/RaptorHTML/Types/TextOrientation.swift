//
// TextOrientation.swift
// RaptorHTML
// https://raptor.build
// See LICENSE for license information.
//

/// Defines the orientation of text characters in a line.
public enum TextOrientation: String, Sendable, Hashable {
    case mixed
    case upright
    case sideways

    var css: String { rawValue }
}
