//
// ButtonSizingModifier.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

public extension HTML {
    /// Sets how the button should size itself
    /// - Parameter sizing: The button sizing behavior to apply
    /// - Returns: A modified button with the specified sizing
    func buttonSizing(_ sizing: ButtonSizing) -> some HTML {
        self.class(sizing.cssClass)
    }
}

public extension InlineContent {
    /// Sets how the button should size itself
    /// - Parameter sizing: The button sizing behavior to apply
    /// - Returns: A modified button with the specified sizing
    func buttonSizing(_ sizing: ButtonSizing) -> some InlineContent {
        self.class(sizing.cssClass)
    }
}
