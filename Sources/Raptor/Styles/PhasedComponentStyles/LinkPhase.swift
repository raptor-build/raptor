//
// LinkPhase.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

/// Represents the interactive state (or “phase”) of a link during user interaction.
public enum LinkPhase: String, Sendable, Hashable, Equatable, CaseIterable {
    /// The link's default, resting state.
    case initial
    /// The state when the user’s pointer hovers over the link.
    case hovered
}

extension LinkPhase: InteractionPhase {
    public func selector(from base: Selector) -> Selector {
        switch self {
        case .initial:  base
        case .hovered:  base.with(.hover)
        }
    }
}
