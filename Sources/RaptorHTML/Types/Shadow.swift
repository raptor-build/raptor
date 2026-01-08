//
// Shadow.swift
// RaptorHTML
// https://raptor.build
// See LICENSE for license information.
//

/// Represents a single shadow layer in a CSS-like styling context.
public struct Shadow: Sendable, Hashable {

    /// The horizontal offset of the shadow.
    /// Positive values move the shadow to the right, negative to the left.
    let x: LengthUnit

    /// The vertical offset of the shadow.
    /// Positive values move the shadow downward, negative upward.
    let y: LengthUnit

    /// The blur radius of the shadow.
    /// Higher values create a softer, more diffuse shadow.
    let radius: LengthUnit?

    /// The color of the shadow.
    /// If omitted, the rendering engine may use the element’s default or computed color.
    let color: Color?

    /// Whether this shadow is an **inner shadow** (`true`) or a **regular outer shadow** (`false`).
    /// Mirrors the `inset` keyword in CSS.
    let inset: Bool

    /// Initializes a new `Shadow` instance.
    /// - Parameters:
    ///   - color: The color of the shadow. Defaults to `nil`.
    ///   - radius: The blur radius of the shadow. Defaults to `nil`.
    ///   - x: The horizontal offset of the shadow.
    ///   - y: The vertical offset of the shadow.
    ///   - inset: Whether the shadow is an inner shadow (`true`) or outer shadow (`false`). Defaults to `false`.
    public init(color: Color? = nil, radius: LengthUnit? = nil, x: LengthUnit, y: LengthUnit, inset: Bool = false) {
        self.x = x
        self.y = y
        self.radius = radius
        self.color = color
        self.inset = inset
    }

    /// A computed CSS representation of the shadow suitable for string serialization.
    /// Example: "inset 2px 2px 5px rgba(0,0,0,0.3)"
    package var css: String {
        var parts: [String] = []
        if inset { parts.append("inset") }
        parts.append("\(x.css)")
        parts.append("\(y.css)")
        if let radius { parts.append(radius.css) }
        if let color { parts.append(color.css) }
        return parts.joined(separator: " ")
    }
}
