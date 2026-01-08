//
// ButtonPhase.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

/// Represents the interactive state (or “phase”) of a button during user interaction.
public enum ButtonPhase: String, Sendable, Hashable, Equatable, CaseIterable {
    /// The button’s default, resting state.
    case initial
    /// The state when the user’s pointer hovers over the button.
    case hovered
    /// The state when the button is actively being pressed.
    case pressed
    /// The state when the button is disabled and not interactive.
    case disabled
}

extension ButtonPhase: InteractionPhase {
    public func selector(from base: Selector) -> Selector {
        switch self {
        case .initial:  base
        case .hovered:  base.with(.hover)
        case .pressed:  base.with(.active)
        case .disabled: base.with(.disabled)
        }
    }
}
