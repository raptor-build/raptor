//
// WhiteSpace.swift
// RaptorHTML
// https://raptor.build
// See LICENSE for license information.
//

/// Controls how white space inside an element is handled.
public enum WhiteSpace: String, Sendable, Hashable {
    case normal
    case nowrap
    case pre
    case preWrap = "pre-wrap"
    case preLine = "pre-line"
    case breakSpaces = "break-spaces"

    var css: String { rawValue }
}
