//
// AspectRatio.swift
// RaptorHTML
// https://raptor.build
// See LICENSE for license information.
//

/// Represents the CSS [`aspect-ratio`](https://developer.mozilla.org/en-US/docs/Web/CSS/aspect-ratio)
/// property, which defines the preferred width-to-height ratio for an element.
public enum AspectRatio: Hashable, Equatable, Sendable, CustomStringConvertible {
    /// A ratio defined by width ÷ height.
    case ratio(Double)

    /// A square ratio (`1 / 1`).
    case square

    /// Defines a ratio from separate width and height integers.
    /// Example: `.ratio(16, 9)` → `"16 / 9"`
    public static func ratio(_ width: Int, _ height: Int) -> Self {
        .ratio(Double(width) / Double(height))
    }

    /// Commonly used aspect ratios.
    public static let sixteenByNine: Self = .ratio(16, 9)
    public static let fourByThree: Self = .ratio(4, 3)
    public static let oneByOne: Self = .square

    public var description: String {
        switch self {
        case let .ratio(value):
            // Emit either fractional form or canonical width/height pair.
            // Using 4 decimal precision like CSS spec examples.
            String(format: "%.4g", value)
        case .square:
            "1 / 1"
        }
    }

    var css: String { description }
}
