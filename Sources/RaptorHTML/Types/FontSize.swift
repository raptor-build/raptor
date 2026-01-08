//
// FontSize.swift
// RaptorHTML
// https://raptor.build
// See LICENSE for license information.
//

/// Represents a CSS `font-size` value, supporting all valid keywords and numeric units.
public enum FontSize: Sendable, Hashable {
    // Absolute-size keywords
    case xxSmall
    case xSmall
    case small
    case medium
    case large
    case xLarge
    case xxLarge

    // Relative-size keywords
    case smaller
    case larger

    // Numeric values
    case length(LengthUnit)
    case percentage(Double)

    public var css: String {
        switch self {
        // Absolute
        case .xxSmall: "xx-small"
        case .xSmall: "x-small"
        case .small: "small"
        case .medium: "medium"
        case .large: "large"
        case .xLarge: "x-large"
        case .xxLarge: "xx-large"

        // Relative
        case .smaller: "smaller"
        case .larger: "larger"

        // Numeric
        case .length(let value): value.css
        case .percentage(let percent): "\(percent)%"
        }
    }
}
