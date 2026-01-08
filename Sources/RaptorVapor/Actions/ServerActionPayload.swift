//
// ServerActionPayload.swift
// RaptorVapor
// https://raptor.build
// See LICENSE for license information.
//

/// Serialized response data sent back to the client.
/// The JavaScript runtime interprets this to update the UI.
struct ServerActionPayload: Content, Sendable {
    /// If set, client performs a redirect.
    var redirect: String?

    /// Whether the client should reload the page.
    var reload: Bool

    /// List of HTML updates to apply.
    var updates: [Update]

    /// One DOM update instruction.
    struct Update: Content, Sendable {
        var id: String
        var html: String
    }
}
