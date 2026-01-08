//
// AnyFetchedDataKey.swift
// RaptorVapor
// https://raptor.build
// See LICENSE for license information.
//

/// A type-erased wrapper around any concrete `FetchedDataKey`.
///
/// Raptor uses this internally to store and retrieve dynamically
/// supplied values (e.g. CMS or runtime server state) without
/// needing to know the specific key type.
struct AnyAppStorageKey {
    /// Uniquely identifies the underlying key type.
    let id: ObjectIdentifier

    /// Provides the fallback value if none is set.
    let defaultValue: Any

    /// Safely attempts to convert stored `Any` values back
    /// into the key’s declared `Value` type.
    let cast: (Any) -> Any?

    /// Creates a type-erased wrapper around a specific `FetchedDataKey`.
    init<K: AppStorageKey>(_ key: K.Type) {
        self.id = ObjectIdentifier(key)
        self.defaultValue = key.defaultValue
        self.cast = { $0 as? K.Value }
    }
}
