//
// OfflineSessionStorageValues.swift
// RaptorVapor
// https://raptor.build
// See LICENSE for license information.
//

/// A no-op session store used during static builds or other non-request contexts.
///
/// `OfflineSessionStorageValues` satisfies Vapor’s `SessionStore` protocol
/// without providing real persistence. All reads return the key’s
/// `defaultValue`, and all writes are ignored. This allows components
/// that access `@SessionStorage` to operate safely when no live request
/// is active.
struct EmptySessionStore: SessionStore {
    /// Returns the default value for the requested session key.
    /// All writes are ignored.
    subscript<K: SessionStorageKey>(key: K.Type) -> K.Value {
        key.defaultValue
    }

    /// Always returns `nil`, indicating that no raw session data exists.
    func rawValue(for key: AnySessionStorageKey) -> Data? {
        nil
    }
}
