//
// MaskOrigin.swift
// RaptorHTML
// https://raptor.build
// See LICENSE for license information.
//

/// Defines the positioning area for the mask image.
public enum MaskOrigin: String, Sendable {
    case borderBox = "border-box"
    case paddingBox = "padding-box"
    case contentBox = "content-box"
    var css: String { rawValue }
}
