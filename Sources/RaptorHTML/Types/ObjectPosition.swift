//
// ObjectPosition.swift
// RaptorHTML
// https://raptor.build
// See LICENSE for license information.
//

/// Represents a two-dimensional object or background position.
///
/// Each axis can be defined by alignment (e.g. `.left`, `.center`) or an explicit offset (`.px(10)`, `.percent(50)`).
/// If both are omitted, defaults to `center center`.
public struct ObjectPosition: Sendable, Hashable {
    var xAlignment: Alignment?
    var yAlignment: Alignment?
    var xOffset: LengthUnit?
    var yOffset: LengthUnit?

    public enum Alignment: String, Sendable, Hashable {
        case left, right, top, bottom, center
        var css: String { rawValue }
    }

    public init(
        xAlignment: Alignment? = nil,
        yAlignment: Alignment? = nil,
        xOffset: LengthUnit? = nil,
        yOffset: LengthUnit? = nil
    ) {
        self.xAlignment = xAlignment
        self.yAlignment = yAlignment
        self.xOffset = xOffset
        self.yOffset = yOffset
    }

    var css: String {
        // 1. Prefer offsets if provided
        let x = xOffset?.css ?? xAlignment?.css ?? "center"
        let y = yOffset?.css ?? yAlignment?.css ?? "center"
        return "\(x) \(y)"
    }

    /// Creates a position using alignment anchors.
    public static func alignment(
        horizontal: Alignment? = nil,
        vertical: Alignment? = nil
    ) -> Self {
        .init(xAlignment: horizontal, yAlignment: vertical)
    }

    /// Creates a position using explicit offset values.
    public static func offset(
        x: LengthUnit? = nil,
        y: LengthUnit? = nil
    ) -> Self {
        .init(xOffset: x, yOffset: y)
    }

    public static let center = Self()
    public static let top = Self.alignment(vertical: .top)
    public static let bottom = Self.alignment(vertical: .bottom)
    public static let left = Self.alignment(horizontal: .left)
    public static let right = Self.alignment(horizontal: .right)
    public static let topLeft = Self.alignment(horizontal: .left, vertical: .top)
    public static let topRight = Self.alignment(horizontal: .right, vertical: .top)
    public static let bottomLeft = Self.alignment(horizontal: .left, vertical: .bottom)
    public static let bottomRight = Self.alignment(horizontal: .right, vertical: .bottom)
}
