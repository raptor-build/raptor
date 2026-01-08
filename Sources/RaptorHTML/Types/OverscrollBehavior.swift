//
// OverscrollBehavior.swift
// RaptorHTML
// https://raptor.build
// See LICENSE for license information.
//

/// Defines how the browser handles overscroll (scroll chaining and rubber-banding).
///
/// Example:
/// ```swift
/// .overscrollBehavior(.contain)
/// ```
public enum OverscrollBehavior: String, Sendable, Hashable {
    /// Default browser behavior.
    case auto
    /// Prevents scroll chaining beyond the element’s bounds.
    case contain
    /// Prevents any overscroll behavior (no bounce or chain).
    case none

    var css: String { rawValue }
}
