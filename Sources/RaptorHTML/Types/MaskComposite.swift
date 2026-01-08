//
// MaskComposite.swift
// RaptorHTML
// https://raptor.build
// See LICENSE for license information.
//

/// Determines how multiple mask layers are composited.
public enum MaskComposite: String, Sendable {
    case add
    case subtract
    case intersect
    case exclude
    var css: String { rawValue }
}
