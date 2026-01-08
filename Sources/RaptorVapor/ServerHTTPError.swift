//
// ServerHTTPError.swift
// RaptorVapor
// https://raptor.build
// See LICENSE for license information.
//

import Raptor

/// A lightweight, server-side representation of an HTTP error used when
/// rendering error pages dynamically through Vapor.
///
/// Unlike Raptor’s built-in error types (such as `PageNotFoundError`),
/// this type is designed specifically for bridging **Vapor's `AbortError`**
/// into Raptor’s rendering system.
///
/// This enables the Raptor renderer to produce correct HTML error pages
/// for all server-side failures, without requiring each Raptor error type
/// to understand Vapor.
struct ServerHTTPError: HTTPError {
    /// The raw HTTP status code associated with the error (e.g., 404 or 500).
    let statusCode: Int

    /// A human-readable title for the error (e.g., “Page Not Found”).
    ///
    /// This is typically used as the `<h1>` text on the error page.
    let title: String

    /// A longer description explaining the failure.
    ///
    /// This appears as supporting text beneath the title in the rendered page.
    let description: String
}
