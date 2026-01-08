//
// RaptorErrorMiddleware.swift
// RaptorVapor
// https://raptor.build
// See LICENSE for license information.
//

/// Middleware that converts thrown errors into Raptor-rendered HTML error pages.
///
/// Any error thrown by a route handler—whether a Vapor `AbortError` or a
/// general Swift error—is translated into a `ServerHTTPError` and rendered
/// using the site's configured `ErrorPage`.
///
/// The generated HTML matches the output of Raptor’s static publishing
/// pipeline, using the same layouts, environment values, and localization.
///
/// This middleware is installed automatically when calling:
///
///     try await app.raptor(MySite())
///
struct RaptorErrorMiddleware: AsyncMiddleware {
    /// Intercepts all incoming requests and handles thrown errors by rendering
    /// a Raptor HTML error page instead of allowing Vapor to output
    /// a plain-text response.
    ///
    /// - Parameters:
    ///   - request: The incoming request being handled.
    ///   - next: The next responder in the Vapor middleware chain.
    /// - Returns: A normal response if no error occurs, otherwise a fully rendered
    ///   HTML error page.
    func respond(to request: Request, chainingTo next: AsyncResponder) async throws -> Response {
        do {
            return try await next.respond(to: request)
        } catch {
            return try handle(error, in: request)
        }
    }

    /// Converts a thrown Swift or Vapor error into a fully rendered Raptor
    /// HTML error page.
    ///
    /// - Parameters:
    ///   - error: The error thrown by downstream middleware or route handlers.
    ///   - request: The request during which the error occurred.
    /// - Returns: A Vapor `Response` containing a localized, Raptor-rendered HTML page.
    private func handle(_ error: Error, in request: Request) throws -> Response {
        let site = request.application.site
        let serverError = ServerHTTPError(any: error)

        return try renderPage(for: request, in: site) { renderer in
            // If no error page was provided, use a built-in default page
            if site.errorPage is EmptyErrorPage {
                let defaultPage = DefaultErrorPage(error: serverError)
                let layout = site.layout(for: defaultPage)
                return renderer.render(defaultPage, for: serverError, using: layout)
            }

            let layout = site.layout(for: site.errorPage)
            return renderer.render(site.errorPage, for: serverError, using: layout)
        }
    }
}
