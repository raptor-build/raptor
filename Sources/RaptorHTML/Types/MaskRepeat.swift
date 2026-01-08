//
// MaskRepeat.swift
// RaptorHTML
// https://raptor.build
// See LICENSE for license information.
//

/// Controls how the mask image repeats.
public enum MaskRepeat: String, Sendable {
    case repeatAll = "repeat"
    case repeatX = "repeat-x"
    case repeatY = "repeat-y"
    case noRepeat = "no-repeat"
    case space
    case round
    var css: String { rawValue }
}
