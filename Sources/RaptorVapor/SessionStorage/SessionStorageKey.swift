//
// SessionStorageKey.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

/// A type-safe key used with `@SessionStorage`.
///
/// Conforming types define the shape of a value that can be persisted
/// across requests in a user’s Vapor session. Each key specifies:
/// - the value’s concrete type, and
/// - a default value returned when nothing is stored in the session.
///
/// Example:
/// ```swift
/// struct CartCount: SessionStorageKey {
///     static let defaultValue = 0
/// }
/// ```
public protocol SessionStorageKey: Sendable {
    /// The type stored for this key. Must be codable so it can be
    /// serialized into the session, and sendable/hashable for safety.
    associatedtype Value: Sendable & Hashable & Codable

    /// The fallback value returned when the session contains no entry.
    static var defaultValue: Value { get }
}
