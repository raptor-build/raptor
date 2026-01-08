//
// Process.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

import Foundation
import Testing
@testable import RaptorCLI

@Suite("Process.execute Tests")
struct ProcessExecuteTests {
    /// Verifies that stdout is captured correctly
    /// when a command produces standard output.
    @Test("Captures stdout")
    func capturesStdout() throws {
        let result = try Process.execute(
            command: #"echo "hello world""#
        )

        #expect(result.output.contains("hello world"))
        #expect(result.error.isEmpty)
    }

    /// Verifies that stderr is captured correctly
    /// when a command produces error output.
    @Test("Captures stderr")
    func capturesStderr() throws {
        let result = try Process.execute(
            command: #"echo "error message" 1>&2"#
        )

        #expect(result.error.contains("error message"))
    }

    /// Ensures stdout and stderr are kept separate
    /// and do not leak into one another.
    @Test("Separates stdout and stderr")
    func separatesStdoutAndStderr() throws {
        let result = try Process.execute(
            command: #"echo "out"; echo "err" 1>&2"#
        )

        #expect(result.output.contains("out"))
        #expect(!result.output.contains("err"))

        #expect(result.error.contains("err"))
        #expect(!result.error.contains("out"))
    }

    /// Ensures the process exits and does not hang
    /// when running a short-lived command.
    @Test("Terminates promptly")
    func terminatesPromptly() throws {
        let start = Date()

        _ = try Process.execute(
            command: #"sleep 0.2"#
        )

        let elapsed = Date().timeIntervalSince(start)
        #expect(elapsed < 1.0)
    }

    /// Verifies that multiple executions are isolated
    /// and do not interfere with one another.
    @Test("Multiple executions are isolated")
    func multipleExecutionsAreIsolated() throws {
        let first = try Process.execute(command: #"echo "first""#)
        let second = try Process.execute(command: #"echo "second""#)

        #expect(first.output.contains("first"))
        #expect(!first.output.contains("second"))

        #expect(second.output.contains("second"))
        #expect(!second.output.contains("first"))
    }

    /// Ensures that commands producing no output
    /// still return successfully.
    @Test("Handles empty output")
    func handlesEmptyOutput() throws {
        let result = try Process.execute(
            command: #"true"#
        )

        #expect(result.output.isEmpty)
        #expect(result.error.isEmpty)
    }

    /// Verifies that non-zero exit commands do not crash
    /// the caller and still return captured output.
    @Test("Handles failing command safely")
    func handlesFailingCommandSafely() throws {
        let result = try Process.execute(
            command: #"echo "fail"; exit 1"#
        )

        #expect(result.output.contains("fail"))
        // Exit status is intentionally not surfaced
        // but the process must still terminate cleanly
    }

    /// Ensures that `then:` does not execute
    /// when an empty subsequent command is provided.
    @Test("Empty subsequent command is ignored")
    func emptySubsequentCommandIsIgnored() throws {
        let result = try Process.execute(
            command: #"echo "main""#,
            then: ""
        )

        #expect(result.output.contains("main"))
    }
}
