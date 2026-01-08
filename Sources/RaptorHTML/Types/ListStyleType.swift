//
// ListStyleType.swift
// RaptorHTML
// https://raptor.build
// See LICENSE for license information.
//

/// Defines the marker type for list items.
///
/// Example:
/// ```swift
/// .listStyleType(.square)
/// ```
public struct ListStyleType: RawRepresentable, Sendable, Hashable, CustomStringConvertible {
    public let rawValue: String
    public var description: String { rawValue }

    public init(rawValue: String) {
        self.rawValue = rawValue
    }

    /// No marker is shown.
    public static let none = Self(rawValue: "none")

    /// A filled circle marker (default for unordered lists).
    public static let disc = Self(rawValue: "disc")

    /// An open circle marker.
    public static let circle = Self(rawValue: "circle")

    /// A filled square marker.
    public static let square = Self(rawValue: "square")

    /// Decimal numbers (1, 2, 3, …).
    public static let decimal = Self(rawValue: "decimal")

    /// Decimal numbers with leading zeros (01, 02, 03, …).
    public static let decimalLeadingZero = Self(rawValue: "decimal-leading-zero")

    /// Lowercase Roman numerals (i, ii, iii, …).
    public static let lowerRoman = Self(rawValue: "lower-roman")

    /// Uppercase Roman numerals (I, II, III, …).
    public static let upperRoman = Self(rawValue: "upper-roman")

    /// Lowercase Latin letters (a, b, c, …).
    public static let lowerAlpha = Self(rawValue: "lower-alpha")

    /// Uppercase Latin letters (A, B, C, …).
    public static let upperAlpha = Self(rawValue: "upper-alpha")

    /// Lowercase Greek letters (α, β, γ, …).
    public static let lowerGreek = Self(rawValue: "lower-greek")

    /// Traditional Hebrew numbering.
    public static let hebrew = Self(rawValue: "hebrew")

    /// Traditional Georgian numbering.
    public static let georgian = Self(rawValue: "georgian")

    /// Traditional Armenian numbering.
    public static let armenian = Self(rawValue: "armenian")

    var css: String { rawValue }
}
