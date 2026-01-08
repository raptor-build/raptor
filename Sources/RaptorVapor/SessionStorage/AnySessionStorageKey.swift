//
// AnySessionStorageKey.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

/// A type-erased wrapper around a concrete `SessionStorageKey`.
///
/// Raptor uses this internally to store and retrieve per-session values
/// without needing to know the key’s concrete type. The wrapper carries:
/// - a unique identifier,
/// - the key’s default value,
/// - the session storage string key, and
/// - a decoding closure for the key’s `Value` type.
struct AnySessionStorageKey {
    /// Uniquely identifies the underlying key type.
    let id: ObjectIdentifier

    /// The key’s default value, type-erased.
    let defaultValue: Any

    /// The string used to store this value inside Vapor’s session.
    let sessionKey: String

    /// Decodes stored JSON data into the key’s value type.
    let decode: @Sendable (Data) throws -> any Sendable

    /// Creates a type-erased wrapper for the given session key.
    /// - Parameter key: The concrete key type being erased.
    init<K: SessionStorageKey>(_ key: K.Type) {
        self.id = ObjectIdentifier(key)
        self.defaultValue = key.defaultValue
        self.sessionKey = String(reflecting: K.self)
        self.decode = { data in
            try JSONDecoder().decode(K.Value.self, from: data)
        }
    }
}
