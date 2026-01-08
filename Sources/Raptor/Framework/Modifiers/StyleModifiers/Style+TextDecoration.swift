//
// Style+TextDecoration.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

public extension Stylable {
    /// Applies a text decoration style to the current element.
    /// - Parameter style: The style to apply, specified as a `TextDecoration` case.
    /// - Returns: The current element with the updated text decoration style applied.
    func textDecoration(_ style: TextDecoration) -> Self {
        self.style(.textDecoration(style))
    }
}
