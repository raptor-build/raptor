//
// CornerShape.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

/// Represents a CSS `corner-shape` value.
///
/// The `corner-shape` property defines the curvature or cut of an element’s corners,
/// extending beyond the capabilities of `border-radius`.
///
/// Example CSS outputs:
/// ```css
/// corner-shape: round;
/// corner-shape: bevel;
/// corner-shape: superellipse(0.75);
/// ```
///
/// See: [CSS Corner Shapes Module Level 1 (Draft)](https://drafts.csswg.org/css-corner-shape/)
public enum CornerShape: Sendable, Hashable {
    /// Standard rounded corners (default).
    case round

    /// Concave corners, creating an inward “scoop” shape.
    case scoop

    /// Beveled (chamfered) corners — flat cuts removing the curve.
    case bevel

    /// Notched corners — removes a square notch instead of rounding.
    case notch

    /// Sharp 90° corners (no rounding).
    case square

    /// A “squircle” shape — a continuous curve between square and circle (iOS-like).
    case squircle

    /// A `superellipse()` value with a specified smoothness factor (0.0 to 1.0+).
    /// Values closer to `0` approach a square, `1` approximates a circle.
    case superellipse(Double)

    /// Returns the CSS string representation for the `corner-shape` value.
    public var css: String {
        switch self {
        case .round: "round"
        case .scoop: "scoop"
        case .bevel: "bevel"
        case .notch: "notch"
        case .square: "square"
        case .squircle: "squircle"
        case .superellipse(let smoothness): "superellipse(\(smoothness))"
        }
    }
}
