//
// RaptorFooter.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

import Foundation

/// Displays "Created in Swift with Raptor", with a link back to the Raptor project on GitHub.
public struct RaptorFooter: HTML {
    public init() {}

    public var body: some HTML {
        Text {
            "Created in Swift with "
            Link("Raptor", destination: URL(static: "https://raptor.build"))
        }
        .multilineTextAlignment(.center)
        .margin(.top, .xLarge)
    }
}
