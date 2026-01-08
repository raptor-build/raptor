//
// BackgroundClipBounds.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

/// Specifies the bounds used when clipping an element.
public enum BackgroundClipBounds: String, Sendable {
    /// Clips to the element’s content bounds.
    case content = "content-box"

    /// Clips to the element’s padding bounds.
    case padding = "padding-box"

    /// Clips to the element’s border bounds.
    case border = "border-box"

    /// Clips to the rendered text glyphs.
    case text

    var styleProperty: Property {
        switch self {
        case .content: .backgroundClip(.contentBox)
        case .padding: .backgroundClip(.paddingBox)
        case .border: .backgroundClip(.borderBox)
        case .text: .backgroundClip(.text)
        }
    }
}
