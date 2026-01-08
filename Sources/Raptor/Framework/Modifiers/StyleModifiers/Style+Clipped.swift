//
// Style+Clipped.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

public extension StyleConfiguration {
    /// Applies CSS `overflow:hidden` to clip the element's content to its bounds.
    /// - Returns: A modified copy of the element with clipping applied
    func clipped() -> Self {
        self.style(.overflow(.hidden))
    }
}
