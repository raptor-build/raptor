//
// MaskMode.swift
// RaptorHTML
// https://raptor.build
// See LICENSE for license information.
//

/// Defines how the mask image’s pixel values are interpreted.
public enum MaskMode: String, Sendable {
    case alpha
    case luminance
    case matchSource = "match-source"
    var css: String { rawValue }
}
