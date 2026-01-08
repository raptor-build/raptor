//
// TransitionProperty.swift
// RaptorHTML
// https://raptor.build
// See LICENSE for license information.
//

/// Represents an animatable CSS property for transitions or animations.
///
/// Example:
/// ```swift
/// .transitionProperty(.opacity)
/// .transitionProperty(.custom("border-radius"))
/// ```
public struct TransitionProperty: Sendable, Hashable, Equatable {
    let css: String
    private init(_ css: String) { self.css = css }

    public static let all = Self("all")
    public static let none = Self("none")

    // Visuals
    public static let opacity = Self("opacity")
    public static let visibility = Self("visibility")
    public static let color = Self("color")
    public static let backgroundColor = Self("background-color")
    public static let boxShadow = Self("box-shadow")
    public static let filter = Self("filter")

    // Layout
    public static let width = Self("width")
    public static let height = Self("height")
    public static let top = Self("top")
    public static let right = Self("right")
    public static let bottom = Self("bottom")
    public static let left = Self("left")
    public static let margin = Self("margin")
    public static let padding = Self("padding")

    // Border & Outline
    public static let borderWidth = Self("border-width")
    public static let borderColor = Self("border-color")
    public static let borderRadius = Self("border-radius")
    public static let outlineColor = Self("outline-color")
    public static let outlineWidth = Self("outline-width")
    public static let outlineOffset = Self("outline-offset")

    // Background
    public static let background = Self("background")
    public static let backgroundPosition = Self("background-position")
    public static let backgroundSize = Self("background-size")

    // Transform
    public static let transform = Self("transform")
    public static let rotate = Self("rotate")
    public static let scale = Self("scale")
    public static let translate = Self("translate")
    public static let skew = Self("skew")
    public static let perspective = Self("perspective")

    // Typography
    public static let letterSpacing = Self("letter-spacing")
    public static let lineHeight = Self("line-height")
    public static let wordSpacing = Self("word-spacing")
    public static let fontWeight = Self("font-weight")

    // Motion & Clipping
    public static let clipPath = Self("clip-path")
    public static let offset = Self("offset")
    public static let offsetPath = Self("offset-path")
    public static let offsetDistance = Self("offset-distance")
    public static let offsetRotate = Self("offset-rotate")

    public static func custom(_ name: String) -> Self { Self(name) }
}
extension Collection where Element == TransitionProperty {
    /// Joins multiple transition properties into a comma-separated CSS list.
    var cssList: String { map(\.css).joined(separator: ", ") }
}
