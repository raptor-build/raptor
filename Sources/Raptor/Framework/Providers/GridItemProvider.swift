//
// GridItemProvider.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

/// A type whose subviews resolve to a collection of `AnyGridItem`.
protocol GridItemProvider {
    /// Renderable content for this grid item
    var gridItem: AnyGridItem { get }
}
