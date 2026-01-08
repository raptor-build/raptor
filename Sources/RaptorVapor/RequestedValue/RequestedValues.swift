//
// RequestedValues.swift
// RaptorVapor
// https://raptor.build
// See LICENSE for license information.
//

/// A container for values scoped to the lifetime of a **single request**.
/// These values are written by middleware and resolved inside HTML views
/// via the `@RequestedValue` property wrapper.
///
/// This type is now a **Sendable struct**, allowing
/// request-scoped values to be captured inside `RenderingContext`.
public struct RequestedValues: Sendable {
    /// Stores all request-scoped values keyed by their `RequestedValueKey` identifiers.
    private var values: [ObjectIdentifier: Sendable] = [:]

    /// Creates an empty container for per-request values.
    init() {}

    /// Stores a value for the given request-scoped key.
    public mutating func set<K: RequestedValueKey>(_ key: K.Type, to value: K.Value) {
        values[ObjectIdentifier(key)] = value
    }

    /// Returns the typed value stored for the given key, or `nil` if none exists.
    public func get<K: RequestedValueKey>(_ key: K.Type) -> K.Value? {
        values[ObjectIdentifier(key)] as? K.Value
    }

    /// Provides subscript access to stored values for convenience.
    public subscript<K: RequestedValueKey>(_ key: K.Type) -> K.Value? {
        get { get(key) }
        set { if let newValue { values[ObjectIdentifier(key)] = newValue } }
    }

    /// Returns the untyped raw value for internal property-wrapper lookup.
    func rawValue(for key: AnyRequestedValueKey) -> Sendable? {
        values[key.id]
    }
}
