//
// MenuDropdownConfiguration+Modifiers.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

public extension MenuDropdownConfiguration {
    /// Returns a new configuration by registering and applying a reusable `Style` instance.
    /// - Parameter style: A `Style` instance conforming to the `Style` protocol.
    ///   The style is registered globally and its class name is added to the configuration.
    /// - Returns: A new `MenuDropdownConfiguration` instance that includes the specified style.
    func style(_ style: some Style) -> MenuDropdownConfiguration {
        var copy = self
        BuildContext.register(style)
        copy.styleClasses.append(style.className)
        return copy
    }

    /// Sets the hover background tint color for dropdown items using a CSS variable.
    /// - Parameter color: The color value used for the dropdown item's hover background.
    ///   This will be converted to a CSS‐compatible string via `color.description`.
    /// - Returns: A modified instance with the dropdown hover background tint applied.
    func dropdownItemHoverEffect(_ effect: DropdownItemHoverEffect) -> Self {
        self.style(effect.styleProperty)
    }

    /// Applies a predefined corner radius style to dropdown items.
    /// - Parameter style: The `DropdownItemStyle` defining how dropdown item corners are rendered,
    ///   such as `.roundedCorners` or `.squareCorners`.
    /// - Returns: A modified instance with the corner radius style applied to dropdown items.
    func dropdownItemCornerStyle(_ style: DropdownItemCornerStyle) -> Self {
        self.style("--dropdown-item-corner-radius", style.css)
    }
}
