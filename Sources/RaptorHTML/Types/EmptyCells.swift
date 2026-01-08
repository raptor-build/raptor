//
// EmptyCells.swift
// RaptorHTML
// https://raptor.build
// See LICENSE for license information.
//

/// Controls whether borders and backgrounds are drawn around empty table cells.
///
/// Example:
/// ```swift
/// .emptyCells(.hide)
/// ```
public enum EmptyCells: String, Sendable, Hashable {
    /// Draw borders and backgrounds on empty cells (default).
    case show
    /// Do not draw borders or backgrounds on empty cells.
    case hide

    var css: String { rawValue }
}
