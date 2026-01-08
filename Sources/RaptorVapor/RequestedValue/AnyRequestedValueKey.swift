//
// AnyRequestedValueKey.swift
// RaptorVapor
// https://raptor.build
// See LICENSE for license information.
//

/// A type-erased wrapper around any `RequestedValueKey`.
///
/// `AnyRequestedValueKey` allows the request-value system to store and access
/// heterogeneously typed `RequestedValueKey` definitions in a single dictionary.
/// It exposes only the information needed for lookup:
struct AnyRequestedValueKey {
    /// The unique identifier for the erased key type.
    let id: ObjectIdentifier

    /// The default value declared by the underlying key type.
    /// Stored as `Any` because the concrete value type is erased.
    let defaultValue: Any

    /// Creates a type-erased key from a concrete `RequestedValueKey` type.
    /// - Parameter key: The key type to erase.
    ///
    /// The resulting instance preserves only the key’s identifier and its
    /// static `defaultValue`, enabling it to participate in storage lookups
    /// without knowing the underlying value type.
    init<K: RequestedValueKey>(_ key: K.Type) {
        self.id = ObjectIdentifier(key)
        self.defaultValue = key.defaultValue
    }
}
