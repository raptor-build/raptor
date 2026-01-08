//
// BorderImageOutset.swift
// RaptorHTML
// https://raptor.build
// See LICENSE for license information.
//

/// Represents how far the border image extends beyond the border box.
/// Accepts 1–4 values, each being a `LengthUnit` or a unitless multiplier.
public struct BorderImageOutset: Sendable, CustomStringConvertible {
    /// One individual outset value (either a length or a unitless number).
    public enum Value: Sendable, CustomStringConvertible {
        /// A length value, e.g. `10px`, `2em`
        case length(LengthUnit)
        /// A unitless number multiplier of the border width, e.g. `2`
        case number(Double)

        public var description: String {
            switch self {
            case .length(let value): return value.css
            case .number(let value): return String(value)
            }
        }
    }

    /// The list of 1–4 outset values.
    let values: [Value]

    /// Creates a `BorderImageOutset` from one to four values.
    /// - Parameter values: Between one and four `Value` instances.
    init(_ values: [Value]) {
        precondition((1...4).contains(values.count),
                     "border-image-outset accepts 1–4 values.")
        self.values = values
    }

    /// Creates a `BorderImageOutset` with variadic values.
    init(_ values: Value...) {
        self.init(values)
    }

    public var description: String {
        values.map(\.description).joined(separator: " ")
    }

    var css: String { description }
}
