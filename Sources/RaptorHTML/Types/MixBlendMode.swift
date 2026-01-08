//
// MixBlendMode.swift
// RaptorHTML
// https://raptor.build
// See LICENSE for license information.
//

/// Specifies how an element’s content should blend with the backdrop or background.
public enum MixBlendMode: String, Sendable {
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
    case plusDarker = "plus-darker"
    case plusLighter = "plus-lighter"

    var css: String { rawValue }
}
