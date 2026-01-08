//
// BooleanEnvironmentKey.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

/// Identifies a boolean environment dimension that can drive conditional styling.
///
/// Values of this type are used as stable keys to select a specific
/// boolean environment dimension (such as reduced motion) when applying
/// `environmentEffect`.
public enum BooleanEnvironmentKey: Hashable, Sendable {
    /// Indicates whether the user prefers reduced motion.
    case motionReduced
}

extension BooleanEnvironmentKey {
    static var allValues: [BooleanEnvironmentKey: BooleanEnvironmentValue] {
        [.motionReduced: MotionReducedValue()]
    }
}
