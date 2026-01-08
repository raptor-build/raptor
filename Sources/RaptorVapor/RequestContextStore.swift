//
// RequestContextStore.swift
// RaptorVapor
// https://raptor.build
// See LICENSE for license information.
//

/// Holds request-scoped storage used during a server-side render.
/// This context is fully Sendable so it can flow into the Task-local
/// `RenderingContextHolder`.
struct RequestContextStore: Sendable {
    /// A snapshot of all application-wide `@AppStorage` values for this render pass.
    var appStorage: AppStorageValues

    /// All per-request values available to `@RequestedValue` during rendering.
    var requestedValues: RequestedValues

    /// The server-action IDs collected while rendering the current page.
    var serverActionIDs: [String]
}

extension RequestContextStore {
    /// Session storage is NOT Sendable and NOT copied.
    ///
    /// Instead, it is resolved dynamically through the active Vapor request,
    /// which is stored in `VaporRequestHolder.current`.
    var sessionStorage: SessionStore {
        if let request = ActiveRequest.current {
            request.sessionStorage
        } else {
            // Static build → no session available
            EmptySessionStore()
        }
    }
}

extension RequestContextStore {
    /// Creates a minimal, non-Vapor request context for asset building.
    static var empty: RequestContextStore {
        RequestContextStore(
            appStorage: AppStorageValues(),
            requestedValues: RequestedValues(),
            serverActionIDs: []
        )
    }
}
