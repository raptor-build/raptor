//
// Request+CSRFToken.swift
// RaptorVapor
// https://raptor.build
// See LICENSE for license information.
//

extension Request {
    /// Returns the per-session CSRF token used to protect ServerAction POST requests.
    ///
    /// - If a token already exists in the session, it is returned.
    /// - If not, a new secure random token is generated, stored in the session,
    ///   and then returned.
    ///
    /// This token is automatically embedded into client-side ServerAction
    /// JavaScript and must match the token validated by the server when
    /// handling an action request.
    var csrfToken: String {
        // Reuse the existing token if one is already stored
        if let existing = session.data["_csrf"] {
            return existing
        }

        // Generate a new secure token and persist it in the session
        let new = [UInt8].random(count: 32).base64
        session.data["_csrf"] = new
        return new
    }
}
