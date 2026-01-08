//
// FontKerning.swift
// RaptorHTML
// https://raptor.build
// See LICENSE for license information.
//

/// Controls the usage of kerning information from the font.
public enum FontKerning: Sendable, Hashable {
    /// Browser determines automatically (default behavior).
    case auto
    /// Kerning is enabled.
    case normal
    /// Kerning is disabled.
    case none

    var css: String {
        switch self {
        case .auto: "auto"
        case .normal: "normal"
        case .none: "none"
        }
    }
}
