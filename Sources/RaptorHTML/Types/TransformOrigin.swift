//
// TransformOrigin.swift
// RaptorHTML
// https://raptor.build
// See LICENSE for license information.
//

// swiftlint:disable identifier_name

/// Defines the origin point from which transformations are applied.
///
/// Example:
/// ```swift
/// .transformOrigin(.init(x: .percent(50), y: .percent(50)))
/// ```
public struct TransformOrigin: Sendable, Hashable {
    let x: LengthUnit
    let y: LengthUnit
    let z: LengthUnit?

    var css: String {
        if let z {
            "\(x.css) \(y.css) \(z.css)"
        } else {
            "\(x.css) \(y.css)"
        }
    }

    public init(x: LengthUnit, y: LengthUnit, z: LengthUnit? = nil) {
        self.x = x
        self.y = y
        self.z = z
    }

    /// Common preset: center point.
    public static var center: Self {
        .init(x: .percent(50), y: .percent(50))
    }

    /// Common preset: top left.
    public static var topLeft: Self {
        .init(x: .percent(0), y: .percent(0))
    }
}

// swiftlint:enable identifier_name
