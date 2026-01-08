//
// MotionReducedBranch.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

/// A boolean environment value representing the user's motion preference.
///
/// This dimension maps `true` to a reduced-motion preference and `false`
/// to the absence of a reduced-motion preference.
struct MotionReducedValue: BooleanEnvironmentValue {
    /// Activated when the user prefers reduced motion.
    let `true`: BooleanEnvironmentCondition = .prefersReducedMotion

    /// Activated when the user has no reduced-motion preference.
    let `false`: BooleanEnvironmentCondition = .lacksMotionPreference
}
