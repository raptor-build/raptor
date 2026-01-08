//
// BackfaceVisibility.swift
// RaptorHTML
// https://raptor.build
// See LICENSE for license information.
//

/// Controls whether the element’s back face is visible when rotated.
public enum BackfaceVisibility: Sendable {
    case visible
    case hidden

    var css: String {
        switch self {
        case .visible: "visible"
        case .hidden: "hidden"
        }
    }

    /// Convenience initializer from Bool
    init(_ isVisible: Bool) {
        self = isVisible ? .visible : .hidden
    }
}
