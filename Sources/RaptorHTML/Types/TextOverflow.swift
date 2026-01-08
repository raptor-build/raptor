//
// TextOverflow.swift
// RaptorHTML
// https://raptor.build
// See LICENSE for license information.
//

/// Controls how overflowed text content is rendered.
public enum TextOverflow: Sendable, Hashable {
    /// The default behavior (no clipping or ellipsis).
    case clip
    /// Displays an ellipsis (`…`) to indicate text overflow.
    case ellipsis
    /// Custom string to use when text overflows.
    case custom(String)

    var css: String {
        switch self {
        case .clip: "clip"
        case .ellipsis: "ellipsis"
        case .custom(let string): "\"\(string)\""
        }
    }
}
