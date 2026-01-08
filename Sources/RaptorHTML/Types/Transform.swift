//
// Transform.swift
// RaptorHTML
// https://raptor.build
// See LICENSE for license information.
//

// swiftlint:disable identifier_name

/// Represents a sequence of CSS transform functions (2D or 3D).
///
/// Example:
/// ```swift
/// .transform(.translateX(.px(10)) + .rotate(45) + .scale(1.2))
/// ```
public struct Transform: Sendable, Hashable, CustomStringConvertible {
    private let value: String

    public var description: String { value }
    var css: String { value }

    private init(_ value: String) { self.value = value }

    /// Combines two transforms into a single transform chain.
    public static func + (lhs: Self, rhs: Self) -> Self {
        .init([lhs.value, rhs.value].joined(separator: " "))
    }

    public static func translate(x: LengthUnit? = nil, y: LengthUnit? = nil, z: LengthUnit? = nil) -> Self {
        switch (x, y, z) {
        case let (x?, y?, z?):
            .init("translate3d(\(x.css), \(y.css), \(z.css))")
        case let (x?, y?, nil):
            .init("translate(\(x.css), \(y.css))")
        case let (x?, nil, nil):
            .init("translateX(\(x.css))")
        case let (nil, y?, nil):
            .init("translateY(\(y.css))")
        default:
            .init("translate(0)")
        }
    }

    public static func scale(x: Double, y: Double? = nil, z: Double? = nil) -> Self {
        switch (y, z) {
        case let (y?, z?):
            .init("scale3d(\(x), \(y), \(z))")
        case let (y?, nil):
            .init("scale(\(x), \(y))")
        default:
            .init("scale(\(x))")
        }
    }

    public static func rotate(_ degrees: Double) -> Self {
        .init("rotate(\(degrees)deg)")
    }

    public static func rotate3D(x: Double, y: Double, z: Double, degrees: Double) -> Self {
        .init("rotate3d(\(x), \(y), \(z), \(degrees)deg)")
    }

    public static func skew(x: Double? = nil, y: Double? = nil) -> Self {
        switch (x, y) {
        case let (x?, y?): .init("skew(\(x)deg, \(y)deg)")
        case let (x?, nil): .init("skewX(\(x)deg)")
        case let (nil, y?): .init("skewY(\(y)deg)")
        default: .init("skew(0)")
        }
    }

    public static func perspective(_ length: LengthUnit) -> Self {
        .init("perspective(\(length.css))")
    }

    /// Creates a custom transform function from a raw CSS expression.
    public static func custom(_ css: String) -> Self {
        .init(css)
    }
}

// swiftlint:enable identifier_name
