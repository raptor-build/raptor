//
// Appearance.swift
// RaptorHTML
// https://raptor.build
// See LICENSE for license information.
//

/// Controls how the browser renders the native platform look of UI controls.
///
/// Use this property to override or remove system styling from form controls.
public enum Appearance: Sendable, Hashable {
    /// Removes all platform-native styling.
    case none
    /// Lets the browser choose the platform-default appearance.
    case auto
    /// A custom platform-specific keyword (e.g., `"textfield"`, `"button"`).
    case custom(String)

    var css: String {
        switch self {
        case .none: return "none"
        case .auto: return "auto"
        case .custom(let value): return value
        }
    }
}
