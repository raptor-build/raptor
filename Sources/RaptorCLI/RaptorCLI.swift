//
// RaptorCLI.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

import ArgumentParser
import Foundation

/// The main entry point for our tool. This points users to one
/// of the subcommands.
@main
struct RaptorCLI: ParsableCommand {
    static let discussion = """
    Example usages:
        raptor new MySite – create a new site called MySite.
        raptor build - flattens the current site to HTML.
        raptor run – runs the current site in a local web server.
        raptor run --preview – runs the current site in a local web server, and opens it in your web browser.
    """

    static let configuration = CommandConfiguration(
        commandName: "raptor",
        abstract: "A command-line tool for manipulating Raptor sites.",
        discussion: discussion,
        version: "0.1.0",
        subcommands: [NewCommand.self, BuildCommand.self, RunCommand.self]
    )
}
