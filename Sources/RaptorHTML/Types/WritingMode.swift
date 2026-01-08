//
// WritingMode.swift
// RaptorHTML
// https://raptor.build
// See LICENSE for license information.
//

/// Defines the direction in which lines of text and blocks flow.
///
/// Example:
/// ```swift
/// .writingMode(.verticalRightToLeft)
/// ```
public enum WritingMode: String, Sendable, Hashable {
    /// Horizontal text (default).
    case horizontalTopToBottom = "horizontal-tb"
    /// Vertical text flowing right to left.
    case verticalRightToLeft = "vertical-rl"
    /// Vertical text flowing left to right.
    case verticalLeftToRight = "vertical-lr"

    var css: String { rawValue }
}
