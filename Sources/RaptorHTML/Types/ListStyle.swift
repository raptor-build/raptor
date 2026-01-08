//
// ListStyle.swift
// RaptorHTML
// https://raptor.build
// See LICENSE for license information.
//

/// Shorthand for defining the marker type, position, and image of a list.
///
/// Combines `list-style-type`, `list-style-position`, and `list-style-image`
/// into a single concise declaration.
///
/// Example:
/// ```swift
/// .listStyle(.init(type: .square, position: .inside))
/// ```
public struct ListStyle: Sendable, Hashable {
    let type: ListStyleType
    let position: ListStylePosition?
    let image: ListStyleImage?

    var css: String {
        [type.css, position?.css, image?.css]
            .compactMap { $0 }
            .joined(separator: " ")
    }

    /// Creates a list style configuration.
    /// - Parameters:
    ///   - type: The bullet or numbering style.
    ///   - position: The marker position (inside or outside).
    ///   - image: An optional image for list markers.
    public init(type: ListStyleType, position: ListStylePosition? = nil, image: ListStyleImage? = nil) {
        self.type = type
        self.position = position
        self.image = image
    }
}
