//
// DropdownAnchorModifier.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

public extension HTML {
    /// Sets the anchor point for positioning the menu relative to the button.
    /// - Parameter anchor: The anchor point for the menu.
    /// - Returns: A new `Menu` instance with the updated anchor.
    func dropdownAnchor(_ anchor: MenuAnchor) -> some HTML {
        self.class(anchor.cssClass, anchor.carrotDirection.cssClass)
    }
}

public extension InlineContent {
    /// Sets the anchor point for positioning the menu relative to the button.
    /// - Parameter anchor: The anchor point for the menu.
    /// - Returns: A new `Menu` instance with the updated anchor.
    func dropdownAnchor(_ anchor: MenuAnchor) -> some InlineContent {
        self.class(anchor.cssClass, anchor.carrotDirection.cssClass)
    }
}
