//
// HangingPunctuation.swift
// RaptorHTML
// https://raptor.build
// See LICENSE for license information.
//

/// Controls how punctuation marks are placed relative to line boxes.
///
/// Example:
/// ```swift
/// .hangingPunctuation(.first)
/// ```
public enum HangingPunctuation: String, Sendable, Hashable {
    case none
    case first
    case last
    case allowEnd = "allow-end"
    case forceEnd = "force-end"

    var css: String { rawValue }
}
