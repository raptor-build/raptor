//
// ServerActionHandler.swift
// RaptorVapor
// https://raptor.build
// See LICENSE for license information.
//

/// Binds a concrete ServerAction type to runtime execution.
struct ServerActionHandler<A: ServerAction>: AnyServerActionHandler {
    func handle(_ req: Request) throws -> Response {
        let action = try A.decode(from: req)
        let result = try action.handle(req)
        return try result.encodeResponse(for: req)
    }
}
