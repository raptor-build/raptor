//
// SpacingAmount.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

/// Adaptive spacing amounts to provide consistency in site design.
public enum SemanticSpacing: Int, CaseIterable, Sendable {
    case xSmall = 1
    case small
    case medium
    case large
    case xLarge

    /// Base multiplier used for deriving relative spacing.
    var multiplier: Double {
        switch self {
        case .xSmall: 0.25
        case .small:  0.5
        case .medium: 1.0
        case .large:  1.5
        case .xLarge: 2.0
        }
    }
}
