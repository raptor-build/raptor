//
// TransparencyLevel.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

/// Applies styles based on the user's transparency preferences.
public enum TransparencyLevel: String, Sendable, Hashable, Equatable, CaseIterable {
    /// Reduced transparency preference
    case decreased = "prefers-reduced-transparency: reduce"
    /// Standard transparency preference
    case standard = "prefers-reduced-transparency: no-preference"
}

extension TransparencyLevel: MediaFeature {
    package var condition: String {
        rawValue
    }
}

extension MediaFeature where Self == TransparencyLevel {
    /// Creates a transparency preference media feature.
    /// - Parameter transparency: The transparency preference to apply.
    /// - Returns: A transparency preference media feature.
    static func transparency(_ transparency: TransparencyLevel) -> TransparencyLevel {
        transparency
    }
}

extension TransparencyLevel: EnvironmentEffectValue {}
