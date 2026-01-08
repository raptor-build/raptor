//
// FontWeight.swift
// RaptorHTML
// https://raptor.build
// See LICENSE for license information.
//

/// Represents the CSS [`font-weight`](https://developer.mozilla.org/en-US/docs/Web/CSS/font-weight) property.
///
/// `FontWeight` defines the visual thickness of text glyphs. It supports both
/// keyword-based weights (e.g. `.bold`, `.light`) and numeric weights (100–900).
public enum FontWeight: Hashable, Equatable, Sendable {
    /// Thin (100)
    case thin
    /// Extra-light (200)
    case extraLight
    /// Light (300)
    case light
    /// Normal (400)
    case normal
    /// Medium (500)
    case medium
    /// Semi-bold (600)
    case semiBold
    /// Bold (700)
    case bold
    /// Extra-bold (800)
    case extraBold
    /// Black (900)
    case black
    /// A custom numeric weight (usually between 1 and 1000).
    case custom(Int)
}

extension FontWeight {
    /// The corresponding numeric weight (1–1000).
    var numericValue: Int {
        switch self {
        case .thin:       100
        case .extraLight: 200
        case .light:      300
        case .normal:     400
        case .medium:     500
        case .semiBold:   600
        case .bold:       700
        case .extraBold:  800
        case .black:      900
        case .custom(let value): max(1, min(value, 1000))
        }
    }

    /// Returns the standard CSS string value (`"400"`, `"700"`, etc.).
    var css: String {
        "\(numericValue)"
    }
}
