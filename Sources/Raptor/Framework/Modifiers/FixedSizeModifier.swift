//
// FixedSizeModifier.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

public extension HTML {
    /// Forces an element to be sized based on its content rather than expanding to fill its container.
    /// - Returns: A modified copy of the element with fixed sizing applied
    func fixedSize() -> some HTML {
        self.style(.width(.fitContent))
    }
}

public extension InlineContent {
    /// Forces an element to be sized based on its content rather than expanding to fill its container.
    /// - Returns: A modified copy of the element with fixed sizing applied
    func fixedSize() -> some InlineContent {
        self.style(.width(.fitContent))
    }
}
