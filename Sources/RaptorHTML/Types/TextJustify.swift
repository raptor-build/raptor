//
// TextJustify.swift
// RaptorHTML
// https://raptor.build
// See LICENSE for license information.
//

/// Specifies the justification algorithm to use when `text-align` is `justify`.
public enum TextJustify: String, Sendable, Hashable {
    case auto
    case none
    case interWord = "inter-word"
    case interCharacter = "inter-character"

    var css: String { rawValue }
}
