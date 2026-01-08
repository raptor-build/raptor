//
// BorderCollapse.swift
// RaptorHTML
// https://raptor.build
// See LICENSE for license information.
//

/// Defines whether table cell borders are collapsed into a single border or remain separate.
///
/// Example:
/// ```swift
/// .borderCollapse(.collapse)
/// ```
public enum BorderCollapse: String, Sendable, Hashable {
    /// Adjacent cell borders are merged into a single shared border.
    case collapse
    /// Each cell maintains its own border with space between borders.
    case separate

    var css: String { rawValue }
}
