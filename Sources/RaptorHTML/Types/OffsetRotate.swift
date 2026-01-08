//
// OffsetRotate.swift
// RaptorHTML
// https://raptor.build
// See LICENSE for license information.
//

/// Defines the rotation of an element along a motion path.
public enum OffsetRotate: Sendable, CustomStringConvertible {
    /// Automatically rotates to match the path’s direction.
    case auto

    /// Automatically rotates with an additional offset angle.
    case autoWithAngle(Angle)

    /// A fixed rotation angle (not following the path direction).
    case fixed(Angle)

    public var description: String {
        switch self {
        case .auto: "auto"
        case .autoWithAngle(let angle): "auto \(angle.css)"
        case .fixed(let angle): angle.css
        }
    }

    var css: String { description }
}
