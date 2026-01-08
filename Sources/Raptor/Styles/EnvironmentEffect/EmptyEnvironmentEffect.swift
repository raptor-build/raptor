//
// EmptyEnvironmentEffect.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

/// A lightweight content proxy used inside an environment-driven effect.
///
/// Each environment case receives a fresh instance of this type.
/// You modify it by adding properties, and the system collects the result.
///
/// This type never applies styles immediately—its only job is to gather
/// the properties that should apply *when its environment condition is active*.
public struct EmptyEnvironmentEffect: Sendable, Stylable {
    private(set) var properties: [Property] = []

    /// Adds a custom CSS declaration to this effect.
    public func style(_ property: Property) -> Self {
        var copy = self
        copy.properties.append(property)
        return copy
    }

    /// Hides or shows the element when this environment condition applies.
    public func hidden(_ isHidden: Bool) -> Self {
        guard isHidden else { return self }
        return self.style(.display(.none))
    }

    /// Sets the element’s font size when this environment condition applies.
    /// Pass `nil` to leave the value unchanged.
    public func fontSize(_ value: Double?) -> Self {
        guard let value else { return self }
        return self.style(.fontSize(.px(value)))
    }

    /// Scales the element’s font size relative to the inherited font size.
    /// A value of `1.0` keeps the size unchanged, `1.25` increases it by 25%, and so on.
    /// Pass `nil` to leave the value unchanged.
    public func fontScale(_ value: Double?) -> Self {
        guard let value else { return self }
        return self.style(.fontSize(.em(value)))
    }

    /// Adjusts the font weight (boldness) of this font.
    /// - Parameter weight: The new font weight.
    /// - Returns: A new instance with the updated weight.
    public func fontWeight(_ weight: Font.Weight?) -> Self {
        guard let weight else { return self }
        return self.style(.fontWeight(weight.html))
    }

    /// Aligns this element using a specific alignment. Pass `nil` to leave the value unchanged.
    /// - Parameter alignment: How to align this element.
    /// - Returns: A modified copy of the element with alignment applied
    public func horizontalAlignment(_ alignment: HorizontalAlignment?) -> Self {
        guard let alignment else { return self }
        return self.style(alignment.itemAlignmentStyle)
    }
}
