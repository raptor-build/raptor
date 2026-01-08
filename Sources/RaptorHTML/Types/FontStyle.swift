//
// FontStyle.swift
// RaptorHTML
// https://raptor.build
// See LICENSE for license information.
//

/// Defines the font style (e.g. normal, italic, or oblique).
public enum FontStyle: Sendable, Hashable {
    case normal
    case italic
    case oblique(angle: Double?)

    var css: String {
        switch self {
        case .normal: "normal"
        case .italic: "italic"
        case .oblique(let angle):
            if let angle { "oblique \(angle)deg" } else { "oblique" }
        }
    }
}
