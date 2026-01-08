//
// FontSmoothingMode.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

public enum FontSmoothingMode: Sendable, Equatable, Hashable {
    /// Enables antialiased font rendering.
    case enabled

    /// Disables font smoothing (uses subpixel rendering where available).
    case disabled

    /// Leaves font smoothing behavior to the system or browser defaults.
    case automatic

    /// Returns the CSS declarations for this font-smoothing mode.
    var styles: [Property] {
        switch self {
        case .automatic:
            []
        case .enabled:
            [.custom("-webkit-font-smoothing", value: "subpixel-antialiased"),
             .custom("-moz-osx-font-smoothing", value: "auto")]
        case .disabled:
            [.custom("-webkit-font-smoothing", value: "antialiased"),
             .custom("-moz-osx-font-smoothing", value: "grayscale")]
        }
    }
}
