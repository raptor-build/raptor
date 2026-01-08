//
// RequestContext.swift
// RaptorVapor
// https://raptor.build
// See LICENSE for license information.
//

/// Task-local storage for the active `RequestContextStore` during a render pass.
enum RequestContext {
    @TaskLocal static var current: RequestContextStore?
}
