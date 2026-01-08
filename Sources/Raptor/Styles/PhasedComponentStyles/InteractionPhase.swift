//
// Phase.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

/// A protocol describing a set of visual or interactive states (phases)
/// for an element (e.g. `.initial`, `.hovered`, `.pressed`, `.disabled`).
public protocol InteractionPhase: Hashable, Sendable, CaseIterable, Equatable, Identifiable
where Self.ID == String {
    /// Returns a selector for this phase, relative to a given base selector.
    func selector(from base: Selector) -> Selector
}

extension InteractionPhase {
    public var id: String {
        String(describing: self).lowercased()
    }
}
