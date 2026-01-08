//
// BooleanEnvironmentCondition.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

/// A concrete boolean environment condition backed by a media query.
///
/// These values are internal identifiers that map semantic conditions
/// (such as reduced motion or no preference) to concrete CSS media features.
public enum BooleanEnvironmentCondition: Hashable, Sendable {
    /// Indicates the user prefers reduced motion.
    case prefersReducedMotion

    /// Indicates the user has no reduced-motion preference.
    case lacksMotionPreference
}

extension BooleanEnvironmentCondition {
    /// The media features associated with this condition.
    ///
    /// Used internally to generate conditional CSS rules.
    var mediaFeatures: [MediaFeature] {
        switch self {
        case .prefersReducedMotion:
            [MotionProminence.decreased]
        case .lacksMotionPreference:
            [MotionProminence.standard]
        }
    }
}
