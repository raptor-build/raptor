//
// FontStretch.swift
// RaptorHTML
// https://raptor.build
// See LICENSE for license information.
//

/// Controls the horizontal stretching or condensation of a font face.
public enum FontStretch: Sendable, Hashable {
    case normal
    case condensed
    case expanded
    case percentage(Double)

    var css: String {
        switch self {
        case .normal: "normal"
        case .condensed: "condensed"
        case .expanded: "expanded"
        case .percentage(let value): "\(value)%"
        }
    }
}
