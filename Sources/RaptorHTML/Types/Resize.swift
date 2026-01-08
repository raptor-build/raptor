//
// Resize.swift
// RaptorHTML
// https://raptor.build
// See LICENSE for license information.
//

/// Determines whether an element is resizable by the user.
///
/// Example:
/// ```swift
/// .resize(.both)
/// ```
public enum Resize: String, Sendable, Hashable {
    case none
    case both
    case horizontal
    case vertical
    case block
    case inline

    var css: String { rawValue }
}
