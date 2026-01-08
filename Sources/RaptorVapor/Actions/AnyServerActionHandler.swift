//
// AnyServerActionHandler.swift
// RaptorVapor
// https://raptor.build
// See LICENSE for license information.
//

/// Internal type-erased wrapper for executing server actions.
protocol AnyServerActionHandler: Sendable {
    func handle(_ request: Request) throws -> Response
}
