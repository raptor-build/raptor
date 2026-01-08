//
// GridRowProvider.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

/// A type whose subviews resolve to a `GridRow`.
protocol GridRowProvider {
    /// Converts the row's content into an array of grid items.
    /// - Returns: An array of `GridItem` objects representing each piece of content.
    func gridItems() -> [AnyGridItem]
}
