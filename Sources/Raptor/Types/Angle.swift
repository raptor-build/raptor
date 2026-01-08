//
// Angle.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

/// Represents a CSS angle value, such as degrees (`deg`), radians (`rad`), or turns (`turn`).
///
/// `Angle` provides a type-safe way to define rotation or directional values in CSS transforms,
/// gradients, and animations.
///
/// Examples:
/// ```swift
/// .degrees(45)     // "45deg"
/// .radians(.pi/2)  // "1.57rad"
/// .turns(0.25)     // "0.25turn"
/// ```
public enum Angle: Sendable {
    /// Angle in degrees (e.g. `45deg`).
    /// - Parameter value: The numeric degree value.
    case degrees(Double)

    /// Angle in radians (e.g. `3.14rad`).
    /// - Parameter value: The numeric radian value.
    case radians(Double)

    /// Angle in turns (e.g. `0.5turn` = 180 degrees).
    /// - Parameter value: The number of full rotations.
    case turns(Double)

    /// Returns the CSS string representation (e.g. `"45deg"`).
    var value: String {
        switch self {
        case .degrees(let value): "\(value)deg"
        case .radians(let value): "\(value)rad"
        case .turns(let value): "\(value)turn"
        }
    }

    var css: String {
        value
    }
}

extension Angle {
    /// A zero-angle value (`0deg`).
    public static var zero: Self { .degrees(0) }

    /// Converts this angle to degrees for numeric operations.
    var degreesValue: Double {
        switch self {
        case .degrees(let value): return value
        case .radians(let value): return value * 180 / .pi
        case .turns(let value): return value * 360
        }
    }
}

public extension Angle {
    /// Converts this `Raptor.Angle` to a `RaptorHTML.Angle` representation.
    ///
    /// This allows seamless use of Raptor-defined angles within RaptorHTML components.
    /// For example, Raptor’s `.degrees(45)` becomes `.degrees(45)` in RaptorHTML.
    ///
    /// - Returns: A `RaptorHTML.Angle` equivalent to this instance.
    var html: RaptorHTML.Angle {
        switch self {
        case .degrees(let value): .degrees(value)
        case .radians(let value): .radians(value)
        case .turns(let value): .turns(value)
        }
    }
}
