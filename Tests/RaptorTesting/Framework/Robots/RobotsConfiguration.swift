//
//  RobotsConfiguration.swift
//  Raptor
//  https://raptor.build
//  See LICENSE for license information.
//

import Foundation
import Testing

@testable import Raptor

/// Tests for `RobotsConfiguration`.
@Suite("RobotsConfiguration Tests")
struct RobotsConfigurationTests {
    @Test("Assert that mock conforms to protocol")
    func assertMockConformsToProtocol() throws {
        let mock: Any = RobotsConfigurationMock()
        #expect(mock is RobotsConfiguration)
    }
}

// MARK: - RobotsConfigurationMock

private final class RobotsConfigurationMock: RobotsConfiguration {
    let disallowRules: [DisallowRule] = []
}
