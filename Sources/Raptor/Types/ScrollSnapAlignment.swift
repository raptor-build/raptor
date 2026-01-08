//
// ScrollSnapAlignment.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

/// Snap alignment for scroll snapping
public enum ScrollSnapAlignment: String, CaseIterable, Sendable {
    /// Snaps to the leading edge (start)
    case leading = "start"
    /// Snaps to the center
    case center = "center"
    /// Snaps to the trailing edge (end)
    case trailing = "end"
}
