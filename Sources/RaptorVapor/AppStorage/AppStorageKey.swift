//
// AppStorageKey.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

/// A protocol describing a type-safe key for Raptor’s server-fetched values.
///
/// `FetchedDataKey` defines the shape of a value that can be dynamically
/// supplied at render time — typically by your Vapor application or CMS
/// layer.
///
/// These keys act like a lightweight “server environment”: you set them
/// in your Vapor routes (or admin panel), and Raptor fetches the value
/// during page rendering.
///
/// This system allows site-wide, dynamic, non-static values to flow from
/// the server into your HTML views.
///
/// Example:
///
/// ```swift
/// struct BannerMessageKey: FetchedDataKey {
///     static var defaultValue = ""
/// }
/// ```
///
/// Once defined, you can read this value inside a Raptor view using:
///
/// ```swift
/// @Fetched(BannerMessageKey.self) var banner
/// ```
///
/// And update the value server-side with:
///
/// ```swift
/// app.fetched.set(BannerMessageKey.self, to: "Sale ends tonight!")
/// ```
public protocol AppStorageKey: Sendable {
    /// The type stored under this key.
    associatedtype Value: Sendable, Hashable

    /// The fallback value when the key has not been set.
    static var defaultValue: Value { get }
}
