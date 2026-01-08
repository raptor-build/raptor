//
// HiddenModifier.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

public extension HTML {
    /// Optionally hides the view in the view hierarchy.
    /// - Parameter isHidden: Whether to hide this element or not.
    /// - Returns: A modified copy of the element with visibility applied.
    func hidden(_ isHidden: Bool = true) -> some HTML {
        self.class(isHidden ? "d-none" : nil)
    }
}
