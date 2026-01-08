//
// Request+AppStorage.swift
// RaptorVapor
// https://raptor.build
// See LICENSE for license information.
//

public extension Request {
    /// Accesses the application-wide dynamic storage used by
    /// the `@AppStorage` property wrapper.
    ///
    /// A new `AppStorageValues` container is lazily created and
    /// installed the first time this property is accessed.
    var appStorage: AppStorageValues {
        get { application.appStorage }
        set { application.appStorage = newValue }
    }
}
