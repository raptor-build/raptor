//
// Rotation.swift
// RaptorHTML
// https://raptor.build
// See LICENSE for license information.
//

// swiftlint:disable identifier_name

/// Defines a rotation transformation for the `rotate` property.
///
/// Example:
/// ```swift
/// .rotate(.degrees(45))
/// ```
public struct Rotation: Sendable, Hashable {
    let degrees: Double
    let x: Double?
    let y: Double?
    let z: Double?

    var css: String {
        if let x, let y, let z {
            return "rotate3d(\(x), \(y), \(z), \(degrees)deg)"
        }
        return "\(degrees)deg"
    }

    /// Rotates around the Z-axis (2D rotation).
    public static func degrees(_ value: Double) -> Self {
        .init(x: nil, y: nil, z: nil, degrees: value)
    }

    /// Rotates around a custom 3D axis.
    public init(x: Double? = nil, y: Double? = nil, z: Double? = nil, degrees: Double) {
        self.degrees = degrees
        self.x = x
        self.y = y
        self.z = z
    }
}

// swiftlint:enable identifier_name
