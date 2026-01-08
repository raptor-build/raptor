//
// Process-Execute.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

import Foundation

/// A Process extension that knows how to run a command and
/// return its result. To make things easier, this also knows how
/// to execute a subsequent command while the first one is
/// running, which is important for previewing on a local server.
///
/// Important: This runs all commands through `/bin/bash -c`,
/// which allows us to `kill` a specific process ID belonging
/// to the user.
extension Process {
    /// Runs a command, optionally followed by a second command.
    /// - Parameters:
    ///   - command: The full command to execute. This must be passed as a string
    ///   even though an array might seem better, because `bash -c` executes the
    ///   command as the current user, and that also needs the whole command to be
    ///   passed as a single string rather than an array that is more common.
    ///   - subsequentCommand: A second command to run. Used when previewing the
    ///   local site in a web browser.
    /// - Returns: The contents of stdout and stderr as a tuple.
    @discardableResult
    static func execute(
        command: String,
        then subsequentCommand: String = ""
    ) throws -> (output: String, error: String) {

        let process = Process()
        process.executableURL = URL(fileURLWithPath: "/bin/bash")
        process.arguments = ["-c", command]

        let stdoutPipe = Pipe()
        let stderrPipe = Pipe()
        process.standardOutput = stdoutPipe
        process.standardError = stderrPipe

        // Ensure the subprocess is always cleaned up
        defer {
            if process.isRunning {
                process.terminate()
                process.waitUntilExit()
            }
        }

        // Start the main process synchronously
        try process.run()

        // If a subsequent command exists, run it after the main process starts
        if !subsequentCommand.trimmingCharacters(in: .whitespaces).isEmpty {

            // Give the primary process a moment to bind ports, etc.
            Thread.sleep(forTimeInterval: 0.75)

            let followUp = Process()
            followUp.executableURL = URL(fileURLWithPath: "/bin/bash")
            followUp.arguments = ["-c", subsequentCommand]

            // Fire and forget (browser open, etc.)
            try followUp.run()

            // Block until user presses Return
            _ = readLine()

            // Explicitly terminate the main process
            process.terminate()
            process.waitUntilExit()
        } else {
            // No follow-up command → wait for completion normally
            process.waitUntilExit()
        }

        // Read all stdout and stderr *after* the process exits
        let outputData = stdoutPipe.fileHandleForReading.readDataToEndOfFile()
        let errorData = stderrPipe.fileHandleForReading.readDataToEndOfFile()

        let outputString = String(decoding: outputData, as: UTF8.self)
        let errorString = String(decoding: errorData, as: UTF8.self)

        return (outputString, errorString)
    }
}
