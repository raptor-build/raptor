//
// AppStorage.swift
// RaptorVapor
// https://raptor.build
// See LICENSE for license information.
//

/// A property wrapper that exposes server-supplied, developer-controlled
/// dynamic values inside a Raptor page.
///
/// `@Fetched` retrieves values from the site’s shared `FetchedValues` storage,
/// which developers update inside Vapor routes or background tasks. It behaves
/// similarly to SwiftUI’s `@Environment`, but the value comes from your server's
/// runtime state rather than a static layout configuration.
///
/// ### How it Works
/// - Developers register typed keys by conforming to `FetchedDataKey`.
/// - The server assigns values using:
///
///   ```swift
///   app.fetchedValues.set(BannerMessageKey.self, to: "New promo!")
///   ```
///
/// - During rendering, `@Fetched` reads the value associated with that key.
/// - If no server value exists, it optionally falls back to a wrapper-specific
///   default or the key’s static `defaultValue`.
///
/// ### Example
///
/// ```swift
/// struct BannerMessageKey: FetchedDataKey {
///     static var defaultValue: String = "Welcome!"
/// }
///
/// struct Header: HTML {
///     @Fetched(BannerMessageKey.self) var banner
///
///     var body: some HTML {
///         Text(banner)
///     }
/// }
/// ```
///
/// - Note: Accessing `@Fetched` outside of a rendering context is a programmer
///   error and triggers a runtime `fatalError`.
@propertyWrapper
public struct AppStorage<Value> {
    private let box: AnyAppStorageKey
    private let overrideDefault: Value?

    public init<K: AppStorageKey>(
        _ key: K.Type,
        default overrideDefault: Value? = nil
    ) where K.Value == Value {
        self.box = AnyAppStorageKey(key)
        self.overrideDefault = overrideDefault
    }

    public var wrappedValue: Value {
        // Must be called inside a request handling task
        guard let requestContext = RequestContext.current else {
            fatalError("@AppStorage used outside of request context")
        }

        let storage = requestContext.appStorage

        if let raw = storage.rawValue(for: box),
           let cast = box.cast(raw) as? Value {
            return cast
        }

        if let overrideDefault { return overrideDefault }

        // swiftlint:disable:next force_cast
        return box.defaultValue as! Value
    }
}
