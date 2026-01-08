//
// Rotation.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

// swiftlint:disable identifier_name

import Foundation

/// Represents a CSS `rotate` value, which defines 2D or 3D rotations for transforms.
///
/// The `rotate` property allows elements to be rotated in two or three dimensions using
/// an angle, an axis–angle pair, or a 3D vector and angle. It also supports the keyword `none`
/// to reset rotation.
///
/// Examples:
/// ```swift
/// .rotate(.angle(.deg(45)))          // rotate: 45deg;
/// .rotate(.axis(.x, .turn(1)))       // rotate: x 1turn;
/// .rotate(.vector(x: 1, y: 0, z: 0, angle: .deg(30))) // rotate: 1 0 0 30deg;
/// .rotate(.none)                     // rotate: none;
/// ```
public enum Rotation: Sendable {
    /// A simple 2D rotation using an angle.
    ///
    /// Example: `rotate: 45deg;`
    /// - Parameter angle: The `AngleUnit` representing the amount of rotation.
    case angle(Angle)

    /// Rotates the element around a specific 3D axis (`x`, `y`, or `z`) by a given angle.
    ///
    /// Example: `rotate: y 1turn;`
    /// - Parameters:
    ///   - axis: The axis around which to rotate.
    ///   - angle: The `AngleUnit` value representing the degree of rotation.
    case axis(Axis, Angle)

    /// Rotates the element around an arbitrary 3D vector by a given angle.
    ///
    /// Example: `rotate: 1 0 0 30deg;`
    /// - Parameters:
    ///   - x: The x-component of the vector.
    ///   - y: The y-component of the vector.
    ///   - z: The z-component of the vector.
    ///   - angle: The `AngleUnit` representing the amount of rotation.
    case vector(x: Double, y: Double, z: Double, angle: Angle)

    /// Specifies that no rotation should be applied.
    ///
    /// Example: `rotate: none;`
    case none

    /// The CSS string representation of the rotation value.
    public var css: String {
        switch self {
        case .angle(let angle): angle.value
        case .axis(let axis, let angle): "\(axis.rawValue) \(angle.value)"
        case .vector(let x, let y, let z, let angle): "\(x) \(y) \(z) \(angle.value)"
        case .none: "none"
        }
    }

    /// Defines the 3D axes (`x`, `y`, `z`) used for axis-based rotations.
    public enum Axis: String, Sendable {
        /// Rotation around the X axis.
        case x
        /// Rotation around the Y axis.
        case y
        /// Rotation around the Z axis.
        case z
    }
}

// swiftlint:enable identifier_name
