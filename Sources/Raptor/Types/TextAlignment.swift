//
// TextAlignment.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

/// Controls how inline text content is aligned within an element.
///
/// This affects the layout of text *inside* the element, not the position
/// of the element itself.
///
/// This is equivalent to SwiftUI’s `multilineTextAlignment(_:)`.
public enum TextAlignment: Sendable, Equatable, Hashable {
    /// Aligns text to the leading edge.
    case leading

    /// Centers text horizontally.
    case center

    /// Aligns text to the trailing edge.
    case trailing

    var style: Property {
        switch self {
        case .leading: .textAlign(.start)
        case .center: .textAlign(.center)
        case .trailing: .textAlign(.end)
        }
    }
}

public extension HTML {
    /// Aligns multiline text within this element.
    /// - Parameter alignment: The text alignment to apply.
    /// - Returns: A modified copy of this element with text alignment applied.
    func multilineTextAlignment(_ alignment: TextAlignment) -> some HTML {
        self.style(alignment.style)
    }
}

public extension InlineContent {
    /// Aligns multiline text within this element.
    /// - Parameter alignment: The text alignment to apply.
    /// - Returns: A modified copy of this element with text alignment applied.
    func multilineTextAlignment(_ alignment: TextAlignment) -> some InlineContent {
        self.style(alignment.style)
    }
}
