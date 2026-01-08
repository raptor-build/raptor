//
// ColorSchemePreference.swift
// RaptorHTML
// https://raptor.build
// See LICENSE for license information.
//

/// Represents the preferred color schemes for an element (e.g., light or dark mode).
///
/// Multiple color schemes can be declared, and the user agent chooses the most appropriate one.
public struct ColorSchemePreference: Sendable, Hashable {
    let values: [Scheme]

    /// Enumerates possible color scheme values.
    public enum Scheme: String, Sendable, Hashable {
        /// Light color scheme.
        case light
        /// Dark color scheme.
        case dark
        /// Indicates that only the specified color schemes should be used.
        case only
    }

    /// Initializes a color scheme with one or more values.
    public init(_ values: Scheme...) {
        self.values = values
    }

    var css: String {
        values.map(\.rawValue).joined(separator: " ")
    }
}
