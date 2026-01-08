//
// TextDecoration.swift
// RaptorHTML
// https://raptor.build
// See LICENSE for license information.
//

/// Specifies the style of the text decoration line.
public enum TextDecorationStyle: String, Sendable, Hashable {
    /// A single solid line.
    case solid
    /// Two parallel solid lines.
    case double
    /// A series of dots.
    case dotted
    /// A series of dashes.
    case dashed
    /// A wavy line.
    case wavy

    var css: String { rawValue }
}
