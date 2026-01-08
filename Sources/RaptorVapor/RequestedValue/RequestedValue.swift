//
// RequestedValue.swift
// RaptorVapor
// https://raptor.build
// See LICENSE for license information.
//

@propertyWrapper
public struct RequestedValue<Value> {
    /// The erased key used to locate the value in `RequestedValues`.
    private let key: AnyRequestedValueKey

    /// An optional caller-provided default value that overrides the key’s
    /// declared static default.
    private let overrideDefault: Value?

    /// Creates a wrapper that retrieves a value associated with the given
    /// `RequestValueKey` for the duration of the current request.
    ///
    /// - Parameters:
    ///   - type: The key type that identifies this stored value.
    ///   - overrideDefault: A value to return if no value is stored for the key.
    ///     If omitted, the key’s `defaultValue` is used instead.
    ///
    /// Values are resolved from the `RequestedValues` container within the
    /// active `RequestContext`. If accessed outside of a request, this
    /// property will trap with a fatal error.
    public init<K: RequestedValueKey>(
        _ type: K.Type,
        default overrideDefault: Value? = nil
    ) where K.Value == Value {
        self.key = AnyRequestedValueKey(type)
        self.overrideDefault = overrideDefault
    }

    /// Returns the value associated with this key for the current request.
    ///
    /// Lookup order:
    /// 1. A value explicitly set in `RequestedValues`
    /// 2. A caller-provided `overrideDefault`
    /// 3. The key’s static `defaultValue`
    ///
    /// Accessing this property outside a request context will trigger
    /// a fatal error.
    public var wrappedValue: Value {
        guard let requestContext = RequestContext.current else {
            fatalError("@RequestedValue used outside of a request context")
        }

        if let raw = requestContext.requestedValues.rawValue(for: key),
           let cast = raw as? Value {
            return cast
        }

        if let overrideDefault { return overrideDefault }

        // swiftlint:disable:next force_cast
        return key.defaultValue as! Value
    }
}
