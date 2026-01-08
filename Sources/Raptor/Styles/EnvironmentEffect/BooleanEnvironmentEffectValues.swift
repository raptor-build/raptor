//
// BooleanEnvironmentEffectValues.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

/// A container of boolean environment conditions exposed to user-facing APIs.
///
/// Properties on this type are accessed via key paths when applying
/// boolean-driven environment effects.
public struct BooleanEnvironmentEffectValues {
    /// Indicates whether the user prefers reduced motion.
    public let isMotionReduced = BooleanEnvironmentKey.motionReduced
}
