//
// ActiveRequest.swift
// RaptorVapor
// https://raptor.build
// See LICENSE for license information.
//

/// Task-local storage for the currently active Vapor `Request` during rendering.
enum ActiveRequest {
    @TaskLocal static var current: Request?
}
