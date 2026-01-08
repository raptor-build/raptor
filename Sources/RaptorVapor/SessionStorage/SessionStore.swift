//
// SessionStore.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

/// A protocol describing a lookup source for session-persisted values.
///
/// `SessionStorageValues` is used by `@SessionStorage` during rendering
/// to retrieve the raw encoded value associated with a given key.
/// Implementations may load from Vapor sessions, in-memory caches, or
/// other backing stores.
protocol SessionStore: Sendable {
    /// Returns the stored raw value (typically encoded data) for the key,
    /// or `nil` if no session value exists.
    func rawValue(for key: AnySessionStorageKey) -> Data?
}

/// A no-op session storage provider used when no session system is active.
///
/// This implementation always returns `nil`, causing `@SessionStorage`
/// to fall back to its override default or the key’s static default.
struct EmptySessionStorageValues: SessionStore {
    @inlinable
    func rawValue(for key: AnySessionStorageKey) -> Data? {
        nil
    }
}
