//
// IdentityTrait.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

/// A marker type used to identify an aspect of an element’s identity.
public protocol IdentityTrait: Sendable, SendableMetatype {}

extension IdentityTrait {
    /// The boolean `data-*` attribute name used to represent this identity trait in the DOM.
    static var attributeName: String {
        "data-" +
        String(describing: self)
            .kebabCased()
            .lowercased()
    }
}
