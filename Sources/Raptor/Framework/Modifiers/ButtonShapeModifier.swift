//
// ButtonShapeModifier.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

public extension HTML {
    /// Sets the shape/corner radius of the button
    /// - Parameter shape: The button shape to apply
    /// - Returns: A modified button with the specified shape
    func buttonShape(_ shape: ButtonShape) -> some HTML {
        self.class(shape.cssClass)
    }
}

public extension InlineContent {
    /// Sets the shape/corner radius of the button
    /// - Parameter shape: The button shape to apply
    /// - Returns: A modified button with the specified shape
    func buttonShape(_ shape: ButtonShape) -> some InlineContent {
        self.class(shape.cssClass)
    }
}
