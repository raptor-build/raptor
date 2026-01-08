//
// KnownRobot.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

import Foundation
import Testing

@testable import Raptor

/// Tests for `KnownRobot`.
@Suite("KnownRobot Tests")
struct KnownRobotTests {
    @Test("All KnownRobot cases", arguments: zip(
        KnownRobot.allCases, [
            "Applebot",
            "baiduspider",
            "bingbot",
            "GPTBot",
            "CCBot",
            "Googlebot",
            "slurp",
            "yandex"
        ]
    ))
    func allKnowRobots(robot: KnownRobot, expectedName: String) throws {
        #expect(robot.rawValue == expectedName)
    }
}
