//
// ListStylePosition.swift
// RaptorHTML
// https://raptor.build
// See LICENSE for license information.
//

/// Controls whether list markers appear inside or outside the content box.
///
/// Example:
/// ```swift
/// .listStylePosition(.inside)
/// ```
public enum ListStylePosition: String, Sendable, Hashable {
    case inside
    case outside

    var css: String { rawValue }
}
