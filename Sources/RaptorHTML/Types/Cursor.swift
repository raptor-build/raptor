//
// Cursor.swift
// RaptorHTML
// https://raptor.build
// See LICENSE for license information.
//

/// Defines the type of mouse cursor displayed when hovering over an element.
///
/// Example:
/// ```swift
/// .cursor(.pointer)
/// .cursor(Raptor.Cursor.pointer)
/// ```
public enum Cursor: String, Sendable, Hashable {
    /// Default arrow cursor.
    case auto
    /// Cursor indicating a clickable element.
    case pointer
    /// Text input cursor (I-beam).
    case text
    /// Crosshair cursor.
    case crosshair
    /// Move cursor (four arrows).
    case move
    /// Wait or busy cursor.
    case wait
    /// Help cursor (question mark or similar).
    case help
    /// Not allowed / disabled indicator.
    case notAllowed = "not-allowed"
    /// Resizing cursors.
    case colResize = "col-resize"
    case rowResize = "row-resize"
    case grab
    case grabbing
    case zoomIn = "zoom-in"
    case zoomOut = "zoom-out"
    case progress

    /// CSS string representation.
    var css: String { rawValue }
}
