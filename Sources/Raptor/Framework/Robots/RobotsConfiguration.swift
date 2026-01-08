//
// RobotsConfiguration.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

/// A simple protocol that lets users create custom robot configurations easily.
public protocol RobotsConfiguration: Sendable {
    var disallowRules: [DisallowRule] { get }
}
