//
// TextEmphasisPosition.swift
// RaptorHTML
// https://raptor.build
// See LICENSE for license information.
//

/// Specifies the position of emphasis marks relative to text.
///
/// Example:
/// ```swift
/// .textEmphasisPosition(.over)
/// ```
public enum TextEmphasisPosition: String, Sendable, Hashable {
    /// Marks appear above the text (horizontal) or right (vertical).
    case over
    /// Marks appear below the text (horizontal) or left (vertical).
    case under
    /// Marks appear to the right of vertical text.
    case right
    /// Marks appear to the left of vertical text.
    case left

    var css: String { rawValue }
}
