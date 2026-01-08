//
// OverflowAnchor.swift
// RaptorHTML
// https://raptor.build
// See LICENSE for license information.
//

/// Controls how the browser handles *scroll anchoring* within an overflowing container.
///
/// Scroll anchoring prevents visible jumps when content above a user’s viewport changes size dynamically.
/// Setting this to `.none` disables this stabilization behavior for the element.
///
/// Example:
/// ```swift
/// .overflowAnchor(.none)
/// ```
public enum OverflowAnchor: String, Sendable, Hashable {
    /// Default browser behavior — scroll anchoring is enabled.
    case auto
    /// Disables scroll anchoring for this element.
    case none

    var css: String { rawValue }
}
