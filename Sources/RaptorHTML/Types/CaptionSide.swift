//
// CaptionSide.swift
// RaptorHTML
// https://raptor.build
// See LICENSE for license information.
//

/// Specifies the position of a table caption.
///
/// Example:
/// ```swift
/// .captionSide(.bottom)
/// ```
public enum CaptionSide: String, Sendable, Hashable {
    case top
    case bottom

    var css: String { rawValue }
}
