//
// Overflow.swift
// RaptorHTML
// https://raptor.build
// See LICENSE for license information.
//

/// Defines how overflowing content is handled.
public enum Overflow: CustomStringConvertible, Sendable {
    case visible, hidden, scroll, auto, clip

    public var description: String {
        switch self {
        case .visible: "visible"
        case .hidden: "hidden"
        case .scroll: "scroll"
        case .auto: "auto"
        case .clip: "clip"
        }
    }

    var css: String { description }
}
