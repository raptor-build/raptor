//
// ActionRouter.swift
// RaptorVapor
// https://raptor.build
// See LICENSE for license information.
//

/// Central registry & router for all server actions.
///
/// This type is a global singleton used by Raptor.
/// It stores shared mutable state, and because it is now an `actor`,
/// thread-safety is automatically guaranteed by Swift's actor isolation.
///
/// Each server action type is registered exactly once and then
/// invoked via HTTP POST requests to `/_actions/:id`.
actor ActionRouter {
    /// Global singleton used by Vapor routing.
    ///
    /// Accessing this value is thread-safe because actors
    /// serialize access to their internal mutable state.
    static let shared = ActionRouter()

    /// Internal storage of registered action handlers,
    /// keyed by the server action's unique endpoint identifier.
    private var handlers: [String: AnyServerActionHandler] = [:]

    private init() {}

    /// Registers a server action handler so it can be invoked by HTTP requests.
    /// - Parameter type: A concrete `ServerAction` type.
    ///
    /// Once registered, incoming requests with a matching endpoint
    /// will be dispatched to the appropriate handler instance.
    func register<A: ServerAction>(_ type: A.Type) {
        handlers[type.endpoint] = ServerActionHandler<A>()
    }

    /// Dispatches an incoming action request to the appropriate handler.
    /// - Parameter req: The incoming Vapor `Request`.
    /// - Returns: A rendered `Response` returned by the action handler.
    ///
    /// This validates the CSRF token, extracts the action identifier,
    /// and then invokes the corresponding handler. If no handler exists,
    /// a `404 Not Found` is thrown.
    func route(_ request: Request) throws -> Response {
        // Validate CSRF token
        guard let token = request.headers.first(name: "X-CSRF-Token"),
              token == request.csrfToken else {
            throw Abort(.forbidden, reason: "Invalid CSRF token")
        }

        guard let id = request.parameters.get("id") else {
            throw Abort(.notFound, reason: "Missing action identifier")
        }

        guard let handler = handlers[id] else {
            throw Abort(
                .notFound,
                reason: "No server action registered for endpoint: \(id)"
            )
        }

        return try handler.handle(request)
    }
}
