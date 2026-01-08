//
// FontVariant.swift
// RaptorHTML
// https://raptor.build
// See LICENSE for license information.
//

/// Controls the use of alternate glyphs and typographic variants.
public enum FontVariant: Sendable, Hashable {
    case normal
    case smallCaps

    var css: String {
        switch self {
        case .normal: "normal"
        case .smallCaps: "small-caps"
        }
    }
}
