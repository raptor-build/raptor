//
// AppStorageValues.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

/// A container that stores server-supplied dynamic values used by the
/// `@AppStorage` property wrapper during page rendering.
///
/// `AppStorageValues` acts as the runtime "injection source" for all fetched keys:
/// developers update these values inside Vapor routes, and Raptor exposes them
/// to HTML views through `@AppStorage`.
///
/// Values persist for the lifetime of the application and default to each
/// key’s `defaultValue`.
public struct AppStorageValues: Sendable {
    private var values: [ObjectIdentifier: Sendable] = [:]

    init() {}

    /// Assigns a new value for the given fetched-data key.
    public mutating func set<K: AppStorageKey>(_ key: K.Type, to value: K.Value) {
        values[ObjectIdentifier(key)] = value
    }

    /// Retrieves the stored value for the given key.
    public func value<K: AppStorageKey>(for key: K.Type) -> K.Value? {
        values[ObjectIdentifier(key)] as? K.Value
    }

    /// Internal lookup used by the `@AppStorage` property wrapper.
    func rawValue(for box: AnyAppStorageKey) -> Sendable? {
        values[box.id]
    }
}
