//
// Translate.swift
// RaptorHTML
// https://raptor.build
// See LICENSE for license information.
//

// swiftlint:disable identifier_name

/// Moves an element along one or more axes.
///
/// Example:
/// ```swift
/// .translate(.init(x: .px(10), y: .percent(50)))
/// ```
public struct Translate: Sendable, Hashable {
    let x: LengthUnit
    let y: LengthUnit?
    let z: LengthUnit?

    var css: String {
        if let z {
            return "\(x.css) \(y?.css ?? "0") \(z.css)"
        } else if let y {
            return "\(x.css) \(y.css)"
        } else {
            return x.css
        }
    }

    public init(x: LengthUnit, y: LengthUnit? = nil, z: LengthUnit? = nil) {
        self.x = x
        self.y = y
        self.z = z
    }

    /// Horizontal-only translation.
    public static func x(_ value: LengthUnit) -> Self {
        .init(x: value)
    }

    /// Vertical-only translation.
    public static func y(_ value: LengthUnit) -> Self {
        .init(x: .px(0), y: value)
    }
}

// swiftlint:enable identifier_name
