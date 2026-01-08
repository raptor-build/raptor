//
// Direction.swift
// RaptorHTML
// https://raptor.build
// See LICENSE for license information.
//

/// Specifies the writing direction of text content.
///
/// Example:
/// ```swift
/// .direction(.ltr)
/// ```
public enum WritingDirection: String, Sendable, Hashable {
    /// Left-to-right text flow.
    case leftToRight = "ltr"
    /// Right-to-left text flow.
    case rightToLeft = "rtl"

    var css: String { rawValue }
}
