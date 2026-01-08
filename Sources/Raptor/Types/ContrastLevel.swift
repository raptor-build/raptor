//
// ContrastQuery.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

/// Applies styles based on the user's contrast preferences.
public enum ContrastLevel: String, Sendable, Hashable, Equatable, CaseIterable {
    /// Standard contrast preference
    case normal = "prefers-contrast: no-preference"
    /// High contrast preference
    case high = "prefers-contrast: more"
    /// Low contrast preference
    case low = "prefers-contrast: less"
}

extension ContrastLevel: MediaFeature {
    package var condition: String {
        rawValue
    }
}

extension MediaFeature where Self == ContrastLevel {
    /// Creates a contrast preference media feature.
    /// - Parameter contrast: The contrast preference to apply.
    /// - Returns: A contrast preference media feature.
    static func contrast(_ contrast: ContrastLevel) -> ContrastLevel {
        contrast
    }
}

extension ContrastLevel: EnvironmentEffectValue {}
