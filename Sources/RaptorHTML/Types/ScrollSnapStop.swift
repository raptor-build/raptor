//
// ScrollSnapStop.swift
// RaptorHTML
// https://raptor.build
// See LICENSE for license information.
//

/// Defines whether snapping can pass over possible snap positions.
///
/// Example:
/// ```swift
/// .scrollSnapStop(.always)
/// ```
public enum ScrollSnapStop: String, Sendable, Hashable {
    /// Normal scrolling behavior.
    case normal
    /// Forces the scroll to stop at each snap point.
    case always

    var css: String { rawValue }
}
