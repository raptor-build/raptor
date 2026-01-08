//
// TextTransform.swift
// RaptorHTML
// https://raptor.build
// See LICENSE for license information.
//

/// Controls the capitalization behavior of text.
public enum TextTransform: String, Sendable, Hashable {
    /// Text is displayed normally.
    case none
    /// Transforms all text to uppercase.
    case uppercase
    /// Transforms all text to lowercase.
    case lowercase
    /// Capitalizes the first letter of each word.
    case capitalize

    var css: String { rawValue }
}
