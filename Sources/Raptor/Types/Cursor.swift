//
// Cursor.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

public enum Cursor: String, CaseIterable, Sendable {
    /// The cursor to display based on the current context. E.g., equivalent to text when hovering text.
    case automatic = "auto"

    /// No cursor is rendered.
    case pointer

    /// Something can be zoomed (magnified) in.
    case zoomIn = "zoom-in"

    /// Something can be zoomed (magnified) out.
    case zoomOut = "zoom-out"
}

extension Cursor {
    /// Converts this `Raptor.Cursor` into a `RaptorHTML.Cursor` representation.
    var html: RaptorHTML.Cursor {
        switch self {
        case .automatic: .auto
        case .pointer: .pointer
        case .zoomIn: .zoomIn
        case .zoomOut: .zoomOut
        }
    }
}
