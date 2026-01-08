//
// DisabledModifier.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

public extension HTML {
    /// Sets whether the button is disabled
    /// - Parameter disabled: Whether the button should be disabled
    /// - Returns: A modified button with the specified disabled state
    func disabled(_ disabled: Bool = true) -> some HTML {
        self.attribute("disabled")
    }
}

public extension InlineContent {
    /// Sets whether the button is disabled
    /// - Parameter disabled: Whether the button should be disabled
    /// - Returns: A modified button with the specified disabled state
    func disabled(_ disabled: Bool = true) -> some InlineContent {
        self.attribute("disabled")
    }
}
