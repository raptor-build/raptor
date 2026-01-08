//
// WordBreak.swift
// RaptorHTML
// https://raptor.build
// See LICENSE for license information.
//

/// Specifies how words should break when reaching the end of a line.
public enum WordBreak: String, Sendable, Hashable {
    case normal
    case breakAll = "break-all"
    case keepAll = "keep-all"
    case breakWord = "break-word"

    var css: String { rawValue }
}
