//
// Isolation.swift
// RaptorHTML
// https://raptor.build
// See LICENSE for license information.
//

/// Determines whether an element creates a new stacking context.
///
/// Example:
/// ```swift
/// .isolation(.isolate)
/// ```
public enum Isolation: String, Sendable, Hashable {
    /// Element participates in its parent stacking context (default).
    case auto
    /// Element creates a new stacking context for its descendants.
    case isolate

    var css: String { rawValue }
}
