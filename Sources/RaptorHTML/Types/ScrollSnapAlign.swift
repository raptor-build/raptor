//
// ScrollSnapAlign.swift
// RaptorHTML
// https://raptor.build
// See LICENSE for license information.
//

/// Specifies how elements align relative to snap positions when scrolling.
///
/// Example:
/// ```swift
/// .scrollSnapAlign(.center)
/// ```
public enum ScrollSnapAlign: String, Sendable, Hashable {
    case none
    case start
    case end
    case center

    var css: String { rawValue }
}
