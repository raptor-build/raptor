//
// ListRowContext.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

/// Stores all row-level styling metadata collected during HTML rendering
/// for a single list item.
struct ListRowContext: Sendable {
    /// The styles to apply to the list row.
    var styles: [Property] = []
}
