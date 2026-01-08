//
// BoxShadow.swift
// RaptorHTML
// https://raptor.build
// See LICENSE for license information.
//

/// Represents a shadow cast by an element’s box.
///
/// Example:
/// ```swift
/// .boxShadow(.init(x: .px(2), y: .px(4), blur: .px(6), color: .black.opacity(0.25)))
/// ```
public struct BoxShadow: Sendable, Hashable {
    let x: LengthUnit
    let y: LengthUnit
    let blur: LengthUnit?
    let spread: LengthUnit?
    let color: Color?
    let inset: Bool

    var css: String {
        var parts: [String] = []
        if inset { parts.append("inset") }
        parts.append(x.css)
        parts.append(y.css)
        if let blur { parts.append(blur.css) }
        if let spread { parts.append(spread.css) }
        if let color { parts.append(color.css) }
        return parts.joined(separator: " ")
    }

    /// Creates a box shadow with optional blur, spread, and color.
    public init(
        x: LengthUnit,
        y: LengthUnit,
        blur: LengthUnit? = nil,
        spread: LengthUnit? = nil,
        color: Color? = nil,
        inset: Bool = false
    ) {
        self.x = x
        self.y = y
        self.blur = blur
        self.spread = spread
        self.color = color
        self.inset = inset
    }

    /// No shadow.
    public static let none = Self(x: .zero, y: .zero)
}
