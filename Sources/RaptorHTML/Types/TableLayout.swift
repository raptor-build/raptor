//
// TableLayout.swift
// RaptorHTML
// https://raptor.build
// See LICENSE for license information.
//

/// Defines how the browser should calculate table column widths and layout.
///
/// Example:
/// ```swift
/// .tableLayout(.fixed)
/// ```
public enum TableLayout: String, Sendable, Hashable {
    /// Table layout algorithm determined by content (default).
    case auto
    /// Fixed layout algorithm where column widths are defined by table width and first row cells.
    case fixed

    var css: String { rawValue }
}
