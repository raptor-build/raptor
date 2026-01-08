//
// TextDecoration.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

public extension HTML {
    /// Applies a text decoration style to the current element.
    /// - Parameter style: The style to apply, specified as a `TextDecoration` case.
    /// - Returns: The current element with the updated text decoration style applied.
    func textDecoration(_ style: TextDecoration) -> some HTML {
        self.style(.textDecoration(style))
    }
}

public extension InlineContent {
    /// Applies a text decoration style to the current element.
    /// - Parameter style: The style to apply, specified as a `TextDecoration` case.
    /// - Returns: The current element with the updated text decoration style applied.
    func textDecoration(_ style: TextDecoration) -> some InlineContent {
        self.style(.textDecoration(style))
    }
}
