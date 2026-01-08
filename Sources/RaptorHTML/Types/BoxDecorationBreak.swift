//
// BoxDecorationBreak.swift
// RaptorHTML
// https://raptor.build
// See LICENSE for license information.
//

/// Defines how an element’s borders and backgrounds behave when split across multiple lines or fragments.
///
/// Example:
/// ```swift
/// .boxDecorationBreak(.clone)
/// ```
public enum BoxDecorationBreak: String, Sendable, Hashable {
    /// Default behavior — fragments share the same box decoration.
    case slice
    /// Each fragment draws borders and backgrounds independently.
    case clone

    var css: String { rawValue }
}
