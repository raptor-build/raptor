//
// BorderRadius.swift
// RaptorHTML
// https://raptor.build
// See LICENSE for license information.
//

/// Represents rounded corners for an element.
public struct BorderRadius: Sendable, CustomStringConvertible {
    var topLeft: LengthUnit
    var topRight: LengthUnit
    var bottomRight: LengthUnit
    var bottomLeft: LengthUnit

    /// Initializes a border radius with per-corner values.
    init(
        topLeft: LengthUnit,
        topRight: LengthUnit,
        bottomRight: LengthUnit,
        bottomLeft: LengthUnit
    ) {
        self.topLeft = topLeft
        self.topRight = topRight
        self.bottomRight = bottomRight
        self.bottomLeft = bottomLeft
    }

    /// Uniform radius for all corners.
    init(_ radius: LengthUnit) {
        self.init(topLeft: radius, topRight: radius, bottomRight: radius, bottomLeft: radius)
    }

    public var description: String {
        "\(topLeft.description) \(topRight.description) \(bottomRight.description) \(bottomLeft.description)"
    }

    var css: String { description }
}
