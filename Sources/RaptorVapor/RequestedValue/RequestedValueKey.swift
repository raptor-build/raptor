//
// RequestedValueKey.swift
// RaptorVapor
// https://raptor.build
// See LICENSE for license information.
//

public protocol RequestedValueKey: Sendable {
    /// The type stored under this key.
    associatedtype Value: Sendable, Hashable

    /// The fallback value when the key has not been set.
    static var defaultValue: Value { get }
}
