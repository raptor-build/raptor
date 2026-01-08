//
// ServerActionResult.swift
// RaptorVapor
// https://raptor.build
// See LICENSE for license information.
//

/// Represents the effect that a server action should cause on the client.
public enum ServerActionResult: Sendable {
    case reloadPage
    case redirect(String)
    case updateHTML(id: String, html: String)
    case none
}

extension ServerActionResult {
    /// Convert the action result into an HTTP response the client can interpret.
    func encodeResponse(for request: Request) throws -> Response {
        let payload = makePayload()

        if let redirect = payload.redirect {
            return request.redirect(to: redirect)
        }

        let response = Response(status: .ok)
        try response.content.encode(payload)
        return response
    }

    /// Convert enum into wire-format payload sent to JS.
    private func makePayload() -> ServerActionPayload {
        switch self {
        case .none:
            return .init(redirect: nil, reload: false, updates: [])
        case .reloadPage:
            return .init(redirect: nil, reload: true, updates: [])
        case .redirect(let url):
            return .init(redirect: url, reload: false, updates: [])
        case .updateHTML(let id, let html):
            return .init(
                redirect: nil,
                reload: false,
                updates: [.init(id: id, html: html)]
            )
        }
    }
}
