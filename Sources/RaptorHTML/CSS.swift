//
// CSS.swift
// RaptorHTML
// https://raptor.build
// See LICENSE for license information.
//

/// Any type that can be expressed in CSS.
package protocol CSS: Sendable {
    /// Returns the rendered CSS.
    func render() -> String
}
