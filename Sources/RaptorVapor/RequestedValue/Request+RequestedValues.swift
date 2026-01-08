//
// Requested+RequestedValue.swift
// RaptorVapor
// https://raptor.build
// See LICENSE for license information.
//

public extension Request {
    /// Internal storage key for `RequestedValues`.
    private struct RaptorRequestedValueKey: StorageKey {
        // swiftlint:disable:next nesting
        typealias Value = RequestedValues
    }

    /// A per-request container for values injected by Raptor at the
    /// start of a render pass.
    ///
    /// `RequestedValues` are created fresh for every request, never persist
    /// across requests, are written by middleware or early routing,
    /// are read inside `@RequestedValue` property wrappers during rendering.
    var requestedValues: RequestedValues {
        get {
            storage[RaptorRequestedValueKey.self] ?? {
                let new = RequestedValues()
                storage[RaptorRequestedValueKey.self] = new
                return new
            }()
        }
        set {
            storage[RaptorRequestedValueKey.self] = newValue
        }
    }
}
