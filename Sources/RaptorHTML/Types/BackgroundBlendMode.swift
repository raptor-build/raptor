//
// BackgroundBlendMode.swift
// RaptorHTML
// https://raptor.build
// See LICENSE for license information.
//

/// Defines how background layers blend with each other and the element’s background color.
public enum BackgroundBlendMode: String, Sendable {
    case normal
    case multiply
    case screen
    case overlay
    case darken
    case lighten
    case colorDodge = "color-dodge"
    case colorBurn = "color-burn"
    case hardLight = "hard-light"
    case softLight = "soft-light"
    case difference
    case exclusion
    case hue
    case saturation
    case color
    case luminosity

    var css: String { rawValue }
}
