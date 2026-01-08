//
// HTTPError+AbortError.swift
// RaptorVapor
// https://raptor.build
// See LICENSE for license information.
//

extension ServerHTTPError {
    /// Creates a `ServerHTTPError` by translating a Vapor `AbortError`
    /// into the shape required for Raptor’s rendering system.
    /// - Parameter abort: The Vapor abort error to convert.
    init(abortError abort: AbortError) {
        self.init(
            statusCode: Int(abort.status.code),
            title: abort.status.reasonPhrase,
            description: abort.reason
        )
    }

    /// Creates a `ServerHTTPError` from *any* Swift `Error`.
    ///
    /// - If the error is a Vapor `AbortError`, it is fully translated.
    /// - Otherwise, a generic **500 Internal Server Error** is returned.
    ///
    /// This ensures that all server errors can produce an HTML page,
    /// even if they originate from non-Vapor sources.
    ///
    /// - Parameter error: Any thrown error captured by a Vapor route.
    init(any error: Error) {
        if let abort = error as? AbortError {
            self.init(abortError: abort)
        } else {
            // Fallback for unknown Swift errors
            self.init(
                statusCode: 500,
                title: "Internal Server Error",
                description: "Something went wrong."
            )
        }
    }
}
