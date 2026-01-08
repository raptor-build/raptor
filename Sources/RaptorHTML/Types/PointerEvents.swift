//
// PointerEvents.swift
// RaptorHTML
// https://raptor.build
// See LICENSE for license information.
//

/// Controls whether an element can receive pointer events.
///
/// Example:
/// ```swift
/// .pointerEvents(.none)
/// ```
public enum PointerEvents: String, Sendable, Hashable {
    case auto
    case none
    case all
    case visible
    case visibleFill = "visibleFill"
    case visibleStroke = "visibleStroke"
    case painted
    case fill
    case stroke
    case boundingBox = "bounding-box"

    var css: String { rawValue }
}
