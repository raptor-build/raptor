//
// ZIndexModifier.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

public extension HTML {
    /// Sets the z-index for this HTML element.
    /// - Parameter index: The z-index value to apply.
    /// - Returns: A modified HTML element with the specified z-index.
    func zIndex(_ index: Int) -> some HTML {
        self.style(.zIndex(index))
    }
}

public extension InlineContent {
    /// Sets the z-index for this inline element.
    /// - Parameter index: The z-index value to apply.
    /// - Returns: A modified inline element with the specified z-index.
    func zIndex(_ index: Int) -> some InlineContent {
        self.style(.zIndex(index))
    }
}
