//
// EffectConfiguration.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

/// A type that represents a scoped style.
protocol ScopedStyleRepresentable: Sendable {
    /// The scoped style represented by this value.
    var scopedStyle: ScopedStyle { get }
}

extension ScopedStyleRepresentable {
    /// A unique identifier for this configuration type.
    var id: String {
        String(describing: self).truncatedHash
    }
}
