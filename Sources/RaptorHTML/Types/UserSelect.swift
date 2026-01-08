//
// UserSelect.swift
// RaptorHTML
// https://raptor.build
// See LICENSE for license information.
//

/// Controls whether the user can select text within an element.
///
/// Example:
/// ```swift
/// .userSelect(.none)
/// ```
public enum UserSelect: String, Sendable, Hashable {
    case auto
    case none
    case text
    case all

    var css: String { rawValue }
}
