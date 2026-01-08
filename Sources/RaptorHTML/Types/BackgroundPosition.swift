//
// BackgroundPosition.swift
// RaptorHTML
// https://raptor.build
// See LICENSE for license information.
//

public struct BackgroundPosition: Sendable, Hashable {
    let css: String

    private init(_ css: String) { self.css = css }

    public static let center = Self("center")
    public static let top = Self("top")
    public static let bottom = Self("bottom")
    public static let left = Self("left")
    public static let right = Self("right")
    public static let topLeft = Self("top left")
    public static let topRight = Self("top right")
    public static let bottomLeft = Self("bottom left")
    public static let bottomRight = Self("bottom right")

    /// Represents horizontal alignment anchors.
    public enum HorizontalAlignment: String, Sendable, Hashable, CaseIterable {
        /// Aligns content to the left edge.
        case left
        /// Centers content horizontally.
        case center
        /// Aligns content to the right edge.
        case right

        var css: String { rawValue }
    }

    /// Represents vertical alignment anchors.
    public enum VerticalAlignment: String, Sendable, Hashable, CaseIterable {
        /// Aligns content to the top edge.
        case top
        /// Centers content vertically.
        case center
        /// Aligns content to the bottom edge.
        case bottom

        var css: String { rawValue }
    }

    /// Creates a background position using alignment anchors.
    /// - Parameters:
    ///   - horizontal: The horizontal alignment (`.left`, `.center`, `.right`). Defaults to `center` if `nil`.
    ///   - vertical: The vertical alignment (`.top`, `.center`, `.bottom`). Defaults to `center` if `nil`.
    public static func alignment(
        horizontal: HorizontalAlignment? = nil,
        vertical: VerticalAlignment? = nil
    ) -> Self {
        switch (horizontal, vertical) {
        case let (.some(horizontal), .some(vertical)):
            .init("\(horizontal.css) \(vertical.css)")
        case let (.some(horizontal), .none):
            .init("\(horizontal.css) center")
        case let (.none, .some(vertical)):
            .init("center \(vertical.css)")
        case (.none, .none):
            .center
        }
    }

    /// Creates a background position using explicit offsets.
    /// - Parameters:
    ///   - x: The horizontal offset (`.percent(50)`, `.px(20)`), defaults to `50%` if `nil`.
    ///   - y: The vertical offset (`.percent(20)`, `.em(2)`), defaults to `50%` if `nil`.
    public static func offset(
        x: LengthUnit? = nil,
        y: LengthUnit? = nil
    ) -> Self {
        switch (x, y) {
        case let (.some(x), .some(y)):
            .init("\(x.css) \(y.css)")
        case let (.some(x), .none):
            .init("\(x.css) 50%")
        case let (.none, .some(y)):
            .init("50% \(y.css)")
        case (.none, .none):
            .init("50% 50%")
        }
    }

    package static func custom(_ value: String) -> Self {
        .init(value)
    }
}
