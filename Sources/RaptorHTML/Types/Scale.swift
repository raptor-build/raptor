//
// Scale.swift
// RaptorHTML
// https://raptor.build
// See LICENSE for license information.
//

// swiftlint:disable identifier_name

/// Defines a scale transformation for the `scale` property.
///
/// Example:
/// ```swift
/// .scale(.xy(1.2, 1.2))
/// ```
public struct Scale: Sendable, Hashable {
    let x: Double
    let y: Double?
    let z: Double?

    var css: String {
        if let z { return "\(x), \(y ?? x), \(z)" }
        if let y { return "\(x), \(y)" }
        return "\(x)"
    }

    public static func uniform(_ value: Double) -> Self {
        .init(x: value)
    }

    public static func xy(_ x: Double, _ y: Double) -> Self {
        .init(x: x, y: y)
    }

    public init(x: Double, y: Double? = nil, z: Double? = nil) {
        self.x = x
        self.y = y
        self.z = z
    }
}

// swiftlint:enable identifier_name
