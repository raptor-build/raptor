//
// GridAutoFlor.swift
// RaptorHTML
// https://raptor.build
// See LICENSE for license information.
//

/// Defines the automatic placement algorithm for grid items within a grid container.
public enum GridAutoFlow: String, Sendable {
    /// Places items by filling each row before moving to the next.
    case row
    /// Places items by filling each column before moving to the next.
    case column
    /// Fills rows densely, attempting to backfill earlier gaps.
    case rowDense = "row dense"
    /// Fills columns densely, attempting to backfill earlier gaps.
    case columnDense = "column dense"

    /// The CSS string representation of the grid auto-flow behavior.
    var css: String { rawValue }
}
