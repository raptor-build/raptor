//
// StrokeStyle.swift
// RaptorHTML
// https://raptor.build
// See LICENSE for license information.
//

/// Defines the line style of a stroke (border or outline).
public enum StrokeStyle: String, Sendable, CustomStringConvertible {
    /// Specifies no border
    case none
    /// A series of dots
    case dotted
    /// A series of dashes
    case dashed
    /// A single solid line
    case solid
    /// Two parallel solid lines
    case double
    /// A 3D grooved effect that depends on the border color
    case groove
    /// A 3D ridged effect that depends on the border color
    case ridge
    /// A 3D inset effect that depends on the border color
    case inset
    /// A 3D outset effect that depends on the border color
    case outset

    public var description: String { rawValue }
}
