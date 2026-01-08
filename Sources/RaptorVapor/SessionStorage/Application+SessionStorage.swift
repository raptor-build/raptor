//
// Application+SessionStorage.swift
// RaptorVapor
// https://raptor.build
// See LICENSE for license information.
//

public final class SessionStorageValues: SessionStore {
    /// The active Vapor request whose session is used for storage.
    private unowned let request: Request

    /// Creates a session-backed storage container bound to the given request.
    /// - Parameter request: The Vapor request providing the session.
    init(request: Request) {
        self.request = request
    }

    /// Returns the stored value for the given key by decoding the
    /// Base64-encoded JSON data from the session.
    /// - Parameter key: The type-erased session key to look up.
    /// - Returns: The decoded value if present, otherwise `nil`.
    func rawValue(for key: AnySessionStorageKey) -> Data? {
        guard let string = request.session.data[key.sessionKey],
              let data = Data(base64Encoded: string)
        else { return nil }

        return data
    }

    /// Stores a value for the given session key by encoding it as
    /// Base64-encoded JSON and writing it into the Vapor session.
    /// - Parameters:
    ///   - key: The session key describing the value type.
    ///   - value: The value to persist for this user session.
    public func set<K: SessionStorageKey>(_ key: K.Type, to value: K.Value) {
        let box = AnySessionStorageKey(K.self)

        do {
            let data = try JSONEncoder().encode(value)
            let encoded = data.base64EncodedString()
            request.session.data[box.sessionKey] = encoded
        } catch {
            fatalError("Failed to encode session value for \(key): \(error)")
        }
    }

    /// Returns the value stored for the given session key, or the key’s
    /// `defaultValue` if nothing has been persisted for this session.
    public func get<K: SessionStorageKey>(_ key: K.Type) -> K.Value {
        let erased = AnySessionStorageKey(key)

        guard
            let raw = rawValue(for: erased),
            let decoded = try? JSONDecoder().decode(K.Value.self, from: raw)
        else {
            return K.defaultValue
        }

        return decoded
    }

    /// Enables dictionary-style access to session-backed values.
    /// Reading returns `get(key)`, and assigning stores the new value
    /// into Vapor’s session for the current user.
    public subscript<K: SessionStorageKey>(_ key: K.Type) -> K.Value {
        get { get(key) }
        set { set(K.self, to: newValue) }
    }
}

public extension Request {
    /// Accesses the session-backed storage helper for this request.
    var sessionStorage: SessionStorageValues {
        SessionStorageValues(request: self)
    }
}
