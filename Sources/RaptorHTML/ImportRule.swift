//
// ImportRule.swift
// RaptorHTML
// https://raptor.build
// See LICENSE for license information.
//

import Foundation

/// Represents a CSS @import rule
package struct ImportRule {
    let source: URL

    package init(_ source: URL) {
        self.source = source
    }

    package func render() -> String {
        "@import url('\(source.absoluteString)');"
    }
}

extension ImportRule: CustomStringConvertible {
    package var description: String {
        render()
    }
}
