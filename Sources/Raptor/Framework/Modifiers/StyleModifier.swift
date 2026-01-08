//
// StyleModifier.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

public extension HTML {
    /// Applies a custom style to the element.
    /// - Parameter style: The style to apply, conforming to the `Style` protocol
    /// - Returns: A modified copy of the element with the style applied
    func style(_ style: some Style) -> some HTML {
        BuildContext.register(style)
        return self.class(style.className)
    }
}

public extension InlineContent {
    /// Applies a custom style to the element.
    /// - Parameter style: The style to apply, conforming to the `Style` protocol
    /// - Returns: A modified copy of the element with the style applied
    func style(_ style: some Style) -> some InlineContent {
        BuildContext.register(style)
        return self.class(style.className)
    }
}
