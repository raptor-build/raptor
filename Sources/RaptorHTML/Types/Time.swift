//
// Time.swift
// RaptorHTML
// https://raptor.build
// See LICENSE for license information.
//

/// Represents a CSS time value, such as seconds (`s`) or milliseconds (`ms`).
///
/// `Time` provides a type-safe way to define animation durations, delays, and transition times.
///
/// Examples:
/// ```swift
/// .seconds(0.5)     // "0.5s"
/// .milliseconds(250) // "250ms"
/// ```
public enum Time: Sendable, Hashable, Equatable {
    /// Time in seconds (e.g. `1.5s`).
    /// - Parameter value: The numeric value in seconds.
    case seconds(Double)

    /// Time in milliseconds (e.g. `500ms`).
    /// - Parameter value: The numeric value in milliseconds.
    case milliseconds(Double)

    /// The CSS string representation of the time value (e.g. `"0.5s"` or `"500ms"`).
    var css: String {
        switch self {
        case .seconds(let value):
            "\(value)s"
        case .milliseconds(let value):
            "\(value)ms"
        }
    }
}
public extension Time {
    /// A zero time value (`0s`).
    static var zero: Self { .seconds(0) }

    /// Converts this time to seconds as a `Double`.
    var secondsValue: Double {
        switch self {
        case .seconds(let value): value
        case .milliseconds(let value): value / 1000
        }
    }

    /// Creates a `Time` value automatically choosing the most compact unit.
    /// - Parameter seconds: A time interval in seconds.
    /// - Returns: A `.milliseconds` value if under 1 second, otherwise `.seconds`.
    static func auto(_ seconds: Double) -> Self {
        if abs(seconds) < 1 {
            .milliseconds(seconds * 1000)
        } else {
            .seconds(seconds)
        }
    }
}
