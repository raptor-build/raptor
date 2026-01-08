//
// ScrollBehavior.swift
// RaptorHTML
// https://raptor.build
// See LICENSE for license information.
//

/// Defines the scrolling behavior for the element.
///
/// Example:
/// ```swift
/// .scrollBehavior(.smooth)
/// ```
public enum ScrollBehavior: String, Sendable, Hashable {
    /// Scrolls immediately (default).
    case auto
    /// Scrolls smoothly.
    case smooth

    var css: String { rawValue }
}
