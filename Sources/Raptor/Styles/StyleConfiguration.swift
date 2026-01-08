//
// StyledHTML.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

/// A concrete type used for style resolution that only holds attributes
public struct StyleConfiguration: Sendable, Hashable, Equatable, Stylable {
    /// A collection of styles.
    var styles = OrderedSet<Property>()

    /// Adds inline styles to the element.
    /// - Parameter values: An array of `InlineStyle` objects
    /// - Returns: The modified `HTML` element
    public func style(_ style: Property) -> Self {
        var copy = self
        copy.styles.append(style)
        return copy
    }

    /// Adds inline styles to the element.
    /// - Parameter values: Variable number of `InlineStyle` objects
    /// - Returns: The modified `HTML` element
    func style(_ property: String, _ value: String) -> Self {
        var copy = self
        copy.styles.append(.custom(property, value: value))
        return copy
    }
}
