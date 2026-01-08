//
// ThemeColorScheme.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

/// The color scheme appearance for UI elements.
public enum ThemeColorScheme: String, Hashable, Equatable, Sendable, CaseIterable {
    /// The light color scheme.
    case light = "light"

    /// The dark color scheme.
    case dark = "dark"

    /// Automatically resolves to either light or dark.
    case any = "auto"

    /// Returns the environment conditions used when resolving styles for this
    /// color scheme.
    var environmentConditions: EnvironmentConditions {
        switch self {
        case .light: .init(colorScheme: .light)
        case .dark: .init(colorScheme: .dark)
        case .any: .init()
        }
    }
}
