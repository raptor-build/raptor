//
// ServerActionJS.swift
// RaptorVapor
// https://raptor.build
// See LICENSE for license information.
//

/// An adapter that turns a ServerAction into a client-side JS Action.
struct ServerActionJS: Action {
    let encoded: String
    let endpoint: String
    let csrf: String

    init<A: ServerAction>(_ action: A, csrfToken: String) throws {
        let encoder = JSONEncoder()
        let payload = try encoder.encode(action)
        let json = String(data: payload, encoding: .utf8) ?? "{}"

        self.endpoint = A.endpoint
        self.encoded = json
        self.csrf = csrfToken
    }

    /// Generates the JavaScript `fetch()` call for the server action.
    func compile() -> String {
        """
        fetch('/_actions/\(endpoint)', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
                'X-CSRF-Token': '\(csrf)'
            },
            body: JSON.stringify(\(encoded))
        })
        .then(r => r.json())
        .then(data => Raptor.handleServerActionResponse(data));
        """
    }
}

extension ServerActionJS {
    /// Fallback when encoding the ServerAction fails.
    static func fallback() -> ServerActionJS {
        ServerActionJS(encoded: "{}", endpoint: "#", csrf: "")
    }

    /// Private initializer used only by fallback().
    private init(encoded: String, endpoint: String, csrf: String) {
        self.encoded = encoded
        self.endpoint = endpoint
        self.csrf = csrf
    }
}
