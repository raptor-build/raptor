//
// Angle.swift
// RaptorHTML
// https://raptor.build
// See LICENSE for license information.
//

/// Represents a CSS angle value used in properties such as
/// `rotate`, `hue-rotate`, and gradient directions.
///
/// Common CSS examples:
/// ```css
/// rotate: 45deg;
/// hue-rotate(90deg);
/// background: linear-gradient(180deg, red, blue);
/// ```
///
/// The `Angle` type ensures type safety and unit clarity
/// while remaining easy to construct from numeric literals.
public enum Angle: Hashable, Equatable, Sendable, CustomStringConvertible {
    /// Degrees — 360° equals one full rotation.
    case degrees(Double)

    /// Radians — `2π` radians equals one full rotation.
    case radians(Double)

    /// Gradians — 400 gradians equals one full rotation.
    case gradians(Double)

    /// Turns — `1turn` equals one full rotation.
    case turns(Double)

    /// A custom angle expression (e.g. `"calc(90deg + 15deg)"`).
    case custom(String)

    /// Returns a string representation matching CSS syntax.
    public var description: String {
        switch self {
        case .degrees(let value): "\(value.formatted(.nonLocalizedDecimal))deg"
        case .radians(let value): "\(value.formatted(.nonLocalizedDecimal))rad"
        case .gradians(let value): "\(value.formatted(.nonLocalizedDecimal))grad"
        case .turns(let value): "\(value.formatted(.nonLocalizedDecimal))turn"
        case .custom(let expression): expression
        }
    }

    /// Returns a string representation matching CSS syntax.
    public var css: String { description }
}
