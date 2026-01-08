//
// ServerAction.swift
// RaptorVapor
// https://raptor.build
// See LICENSE for license information.
//

/// Represents a server-side action triggered by the client.
/// Conforming types automatically decode from incoming JSON,
/// perform async work, and return a `ServerActionResult`.
public protocol ServerAction: Sendable, Codable {
    /// Unique endpoint registered for this action type.
    static var endpoint: String { get }

    /// Execute the action using the current request context.
    func handle(_ request: Request) throws -> ServerActionResult
}

extension ServerAction {
    /// Decodes the incoming request body directly into the action type.
    static func decode(from request: Request) throws -> Self {
        try request.content.decode(Self.self)
    }
}
