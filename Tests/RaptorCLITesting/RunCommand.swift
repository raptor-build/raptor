//
// RunCommand.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

import Foundation
import Testing
@testable import RaptorCLI

@Suite("RunCommand Tests")
struct RunCommandTests {
    private struct RunCommandLogic {
        static func makeServerCommand(
            serverScriptPath: String,
            port: Int,
            directory: String,
            subsite: String
        ) -> String {
            let subsiteArgument = subsite.isEmpty ? "" : "-s \(subsite)"
            return "python3 \(serverScriptPath) -d \(directory) \(subsiteArgument) \(port)"
        }
    }

    @Test("Constructs correct server launch command")
    func serverCommandIsConstructedCorrectly() {
        let result = RunCommandLogic.makeServerCommand(
            serverScriptPath: "/usr/local/bin/raptor-server.py",
            port: 8123,
            directory: "/tmp/Build",
            subsite: ""
        )

        #expect(result.contains("python3"))
        #expect(result.contains("raptor-server.py"))
        #expect(result.contains("/tmp/Build"))
        #expect(result.contains("8123"))
    }

    @Test("Includes subsite argument when present")
    func includesSubsiteArgument() {
        let result = RunCommandLogic.makeServerCommand(
            serverScriptPath: "/usr/local/bin/raptor-server.py",
            port: 8000,
            directory: "/tmp/Build",
            subsite: "/blog"
        )

        #expect(result.contains("-s /blog"))
    }
}
