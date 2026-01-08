//
// MotionQuery.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

/// Applies styles based on the user's motion preferences.
enum MotionProminence: String, Sendable, Hashable, Equatable, CaseIterable {
    /// Reduced motion preference
    case decreased = "prefers-reduced-motion: reduce"
    /// Standard motion preference
    case standard = "prefers-reduced-motion: no-preference"
}

extension MotionProminence: MediaFeature {
    package var condition: String {
        rawValue
    }
}

extension MediaFeature where Self == MotionProminence {
    /// Creates a motion preference media feature.
    /// - Parameter motion: The motion preference to apply.
    /// - Returns: A motion preference media feature.
    static func motion(_ motion: MotionProminence) -> MotionProminence {
        motion
    }
}
