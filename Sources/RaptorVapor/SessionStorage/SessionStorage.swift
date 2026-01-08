//
// SessionStorage.swift
// RaptorVapor
// https://raptor.build
// See LICENSE for license information.
//

/// A property wrapper that exposes a **per-session value** stored in
/// Vapor’s `Session`, allowing user-specific state across requests.
@propertyWrapper
public struct SessionStorage<Value> {
    /// Type-erased key describing the session value.
    private let box: AnySessionStorageKey

    /// Optional override used if no session value exists.
    private let overrideDefault: Value?

    /// Creates a session-backed value for the given key.
    /// - Parameters:
    ///   - key: The session storage key defining the value.
    ///   - overrideDefault: A wrapper-specific fallback if no session value exists.
    public init<K: SessionStorageKey>(
        _ key: K.Type,
        default overrideDefault: Value? = nil
    ) where K.Value == Value {
        self.box = AnySessionStorageKey(key)
        self.overrideDefault = overrideDefault
    }

    /// Returns the stored session value, falling back to:
    /// 1. the override default,
    /// 2. or the key’s static `defaultValue`.
    ///
    /// Accessing this property outside a rendering request
    /// will trigger a fatal error.
    public var wrappedValue: Value {
        guard let requestContext = RequestContext.current else {
            fatalError("@SessionStorage used outside of rendering")
        }

        // Look up the raw session data
        if let raw = requestContext.sessionStorage.rawValue(for: box),
           let decoded = try? box.decode(raw) as? Value {
            return decoded
        }

        if let overrideDefault { return overrideDefault }

        // swiftlint:disable:next force_cast
        return box.defaultValue as! Value
    }
}
