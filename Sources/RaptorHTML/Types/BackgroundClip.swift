//
// BackgroundClip.swift
// RaptorHTML
// https://raptor.build
// See LICENSE for license information.
//

/// Defines how far the background extends within the element’s box.
public enum BackgroundClip: String, Sendable {
    case borderBox = "border-box"
    case paddingBox = "padding-box"
    case contentBox = "content-box"
    case text

    var css: String { rawValue }
}
