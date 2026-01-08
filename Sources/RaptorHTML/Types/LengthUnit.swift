//
// LengthUnit.swift
// RaptorHTML
// https://raptor.build
// See LICENSE for license information.
//

// swiftlint:disable identifier_name
/// Represents a CSS length value with its unit of measurement.
///
/// This type safely encodes CSS length units such as `px`, `em`, `rem`,
/// viewport units, dynamic viewport units, container-query units, and `%`.
/// It provides a strongly typed way to define dimensional values for properties
/// like width, height, margin, padding, and more.
public enum LengthUnit: Hashable, Equatable, Sendable, CustomStringConvertible {
    /// Pixels (`px`)
    /// - Parameter value: The number of pixels.
    case px(Double)

    /// Relative to the root element’s font size (`rem`)
    /// - Parameter value: The multiplier of the root font size.
    case rem(Double)

    /// Relative to the parent element’s font size (`em`)
    /// - Parameter value: The multiplier of the parent font size.
    case em(Double)

    /// Percentage relative to a containing dimension (`%`)
    /// - Parameter value: The percentage value as a `Double`,
    ///   where `100` represents 100%.
    case percent(Double)

    /// Relative to 1% of the viewport width (`vw`)
    case vw(Double)

    /// Relative to 1% of the viewport height (`vh`)
    case vh(Double)

    /// Relative to 1% of the smaller viewport dimension (`vmin`)
    case vmin(Double)

    /// Relative to 1% of the larger viewport dimension (`vmax`)
    case vmax(Double)

    /// Relative to 1% of the dynamic viewport width (`dvw`)
    case dvw(Double)

    /// Relative to 1% of the dynamic viewport height (`dvh`)
    case dvh(Double)

    /// Relative to 1% of the container’s width (`cqw`)
    case cqw(Double)

    /// Relative to 1% of the container’s height (`cqh`)
    case cqh(Double)

    /// Relative to 1% of the container’s smaller dimension (`cqmin`)
    case cqmin(Double)

    /// Relative to 1% of the container’s larger dimension (`cqmax`)
    case cqmax(Double)

    /// A custom CSS expression such as `min(60vw, 300px)` or `calc(100% - 1rem)`
    case custom(String)

    /// A textual representation of this length value suitable for CSS output.
    public var description: String {
        switch self {
        case .px(let v): "\(v.formatted(.nonLocalizedDecimal))px"
        case .rem(let v): "\(v.formatted(.nonLocalizedDecimal))rem"
        case .em(let v): "\(v.formatted(.nonLocalizedDecimal))em"
        case .percent(let v): "\(v.formatted(.nonLocalizedDecimal))%"
        case .vw(let v): "\(v.formatted(.nonLocalizedDecimal))vw"
        case .vh(let v): "\(v.formatted(.nonLocalizedDecimal))vh"
        case .vmin(let v): "\(v.formatted(.nonLocalizedDecimal))vmin"
        case .vmax(let v): "\(v.formatted(.nonLocalizedDecimal))vmax"
        case .dvw(let v): "\(v.formatted(.nonLocalizedDecimal))dvw"
        case .dvh(let v): "\(v.formatted(.nonLocalizedDecimal))dvh"
        case .cqw(let v): "\(v.formatted(.nonLocalizedDecimal))cqw"
        case .cqh(let v): "\(v.formatted(.nonLocalizedDecimal))cqh"
        case .cqmin(let v): "\(v.formatted(.nonLocalizedDecimal))cqmin"
        case .cqmax(let v): "\(v.formatted(.nonLocalizedDecimal))cqmax"
        case .custom(let v): v
        }
    }

    /// Returns the CSS string for this length.
    package var css: String { description }

    /// Represents a value of zero (`0`).
    public static var zero: Self { .custom("0") }

    /// Convenience initializer for integer pixel values.
    public static func px(_ value: Int) -> Self { .px(Double(value)) }

    /// Convenience initializer for integer percent values.
    public static func percent(_ value: Int) -> Self { .percent(Double(value)) }
}
// swiftlint:enable identifier_name
