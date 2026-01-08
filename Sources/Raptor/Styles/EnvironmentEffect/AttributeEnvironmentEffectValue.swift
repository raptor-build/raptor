//
// AttributeEnvironmentEffectValue 2.swift
// Raptor Build
// https://raptor.build
// See LICENSE for license information.
//

/// A finite environment dimension represented by a DOM attribute.
/// - Warning: Do not conform to this protocol directly.
public protocol AttributeEnvironmentEffectValue: Sendable & Hashable & CaseIterable {
    /// The selector representation of the effect.
    var selector: Selector { get }
}
