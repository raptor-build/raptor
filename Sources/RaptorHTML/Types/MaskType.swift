//
// MaskType.swift
// RaptorHTML
// https://raptor.build
// See LICENSE for license information.
//

/// Specifies whether the mask is treated as an alpha or luminance mask.
public enum MaskType: String, Sendable {
    case alpha
    case luminance
    var css: String { rawValue }
}
