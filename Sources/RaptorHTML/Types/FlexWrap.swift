//
// FlexWrap.swift
// RaptorHTML
// https://raptor.build
// See LICENSE for license information.
//

/// Defines whether flex items are forced onto one line or can wrap onto multiple lines.
public enum FlexWrap: String, Sendable, Hashable, CaseIterable {
    /// Flex items are laid out in a single line.
    case nowrap
    /// Flex items wrap onto multiple lines from top to bottom.
    case wrap
    /// Flex items wrap onto multiple lines from bottom to top.
    case wrapReverse = "wrap-reverse"

    /// The CSS string representation of the wrapping behavior.
    var css: String { rawValue }
}
