//
// TextDecoration.swift
// RaptorHTML
// https://raptor.build
// See LICENSE for license information.
//

/// Represents one or more text decoration lines.
///
/// Example:
/// ```swift
/// .textDecoration([.underline, .overline])
/// ```
public struct TextDecoration: OptionSet, Sendable, Hashable {
    public let rawValue: UInt8

    public init(rawValue: UInt8) {
        self.rawValue = rawValue
    }

    public static let underline = Self(rawValue: 1 << 0)
    public static let overline = Self(rawValue: 1 << 1)
    public static let lineThrough = Self(rawValue: 1 << 2)
    public static let none: Self = []

    var css: String {
        if self.isEmpty { return "none" }
        var parts: [String] = []
        if contains(.underline) { parts.append("underline") }
        if contains(.overline) { parts.append("overline") }
        if contains(.lineThrough) { parts.append("line-through") }
        return parts.joined(separator: " ")
    }
}
