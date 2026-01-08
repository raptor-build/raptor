//
// BorderImageRepeat.swift
// RaptorHTML
// https://raptor.build
// See LICENSE for license information.
//

/// Defines how the border image is repeated.
public enum BorderImageRepeat: String, Sendable, CustomStringConvertible {
    case stretch
    case repeatImage = "repeat"
    case round
    case space

    public var description: String { rawValue }
    var css: String { rawValue }
}
