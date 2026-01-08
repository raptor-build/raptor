//
// SiteColorScheme.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

/// The color scheme appearance for UI elements.
@frozen public enum SiteColorScheme: String, Sendable, Hashable, Equatable, CaseIterable {
    /// The light color scheme.
    case light

    /// The dark color scheme.
    case dark

    /// The color scheme of the system.
    case automatic
}
