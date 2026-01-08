//
// Untitled.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

import Foundation
import Testing

@testable import Raptor

/// Tests for `DefaultRobotsConfiguration`.
@Suite("DefaultRobotsConfiguration Tests")
struct DefaultRobotsConfigurationTests {
    @Test("Assert `disallowRules` is empty by default")
    func assertMockConformsToProtocol() throws {
        let configuration = DefaultRobotsConfiguration()
        #expect(configuration.disallowRules.isEmpty)
    }

    @Test("Assert `disallowRules` reflects updates")
    func assertDisallowRules() throws {
        var configuration = DefaultRobotsConfiguration()
        configuration.disallowRules = [DisallowRule(name: "example")]
        #expect(!configuration.disallowRules.isEmpty)
    }
}
