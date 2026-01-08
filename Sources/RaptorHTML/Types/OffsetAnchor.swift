//
// OffsetAnchor.swift
// RaptorHTML
// https://raptor.build
// See LICENSE for license information.
//

/// Defines the anchor point used to position an element along its motion path.
public enum OffsetAnchor: Sendable, CustomStringConvertible {
    /// Automatically determined anchor point.
    case auto

    /// A custom position using percentages or keywords.
    case position(horizontal: BackgroundPosition.HorizontalAlignment,
                  vertical: BackgroundPosition.VerticalAlignment)

    public var description: String {
        switch self {
        case .auto:
            "auto"
        case .position(let horizontal, let vertical):
            "\(horizontal.css) \(vertical.css)"
        }
    }

    var css: String { description }
}
