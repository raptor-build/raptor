//
// ScrollViewItemSizingModifier.swift
// Raptor Build
// https://raptor.build
// See LICENSE for license information.
//

public extension HTML {
    /// Controls how this view is sized when placed inside a `ScrollView`.
    /// - Parameter sizing: The sizing behavior to apply to this view
    ///   when it participates in a scroll view layout.
    /// - Returns: A view that applies the specified scroll view item
    ///   sizing behavior.
    func scrollViewItemSizing(_ sizing: ScrollViewItemSizing) -> some HTML {
        var copy = self
        copy.attributes.append(styles: .variable("scroll-item-size", value: sizing.width))
        return copy
    }
}
