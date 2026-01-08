//
// DisclosurePhase.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

/// Represents the interactive state (or “phase”) of a button during user interaction.
public enum DisclosurePhase: Sendable, Hashable, Equatable, CaseIterable {
    /// The state when the button is disabled and not interactive.
    case opened
    /// The button’s default, resting state.
    case closed
    /// The state when the user’s pointer hovers over the button.
    case hovered

}

extension DisclosurePhase: InteractionPhase {
    public func selector(from base: Selector) -> Selector {
           switch self {
           case .closed: base

           case .opened: base.whenChild(of:
                .class("disclosure")
                .with(.booleanAttribute("open")))

           case .hovered: base
                .with(.hover)
                .whenChild(of: .class("disclosure"))
           }
    }
}
