//
// Application+AppStorageValuesKey.swift
// RaptorVapor
// https://raptor.build
// See LICENSE for license information.
//

extension Application {
    /// The storage key used to install `AppStorageValues`
    /// inside Vapor’s `Application.Storage`.
    private struct AppStorageValuesKey: StorageKey {
        // swiftlint:disable:next nesting
        typealias Value = AppStorageValues
    }

    /// Accesses the application-wide dynamic storage used by
    /// the `@AppStorage` property wrapper.
    ///
    /// A new `AppStorageValues` container is lazily created and
    /// installed the first time this property is accessed.
    var appStorage: AppStorageValues {
        get {
            storage[AppStorageValuesKey.self] ?? {
                let new = AppStorageValues()
                storage[AppStorageValuesKey.self] = new
                return new
            }()
        }
        set {
            storage[AppStorageValuesKey.self] = newValue
        }
    }
}
