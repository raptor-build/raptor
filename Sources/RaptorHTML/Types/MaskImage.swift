//
// MaskImage.swift
// RaptorHTML
// https://raptor.build
// See LICENSE for license information.
//

/// Defines the image(s) used as a mask.
public enum MaskImage: Sendable {
    case none
    case url(String)
    case gradient(Gradient)
    case custom(String)

    var css: String {
        switch self {
        case .none: "none"
        case .url(let value): "url('\(value)')"
        case .gradient(let gradient): gradient.css
        case .custom(let raw): raw
        }
    }
}
