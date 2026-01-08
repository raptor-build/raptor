//
// ComponentConfiguration.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

/// A container describing all inline styles associated with a button across its visual phases.
public typealias MenuDropdownConfiguration = ComponentConfiguration

/// A container describing all styles associated with a component
/// that does **not** have interaction phases (e.g. menus, containers, static elements).
public struct ComponentConfiguration: Hashable, Sendable, Equatable, Stylable {
    /// The collection of inline styles applied directly to this component.
    var styles: [Property] = []

    /// The collection of identifiers of custom styles applied to this component.
    var styleClasses: [String] = []

    /// Returns a new configuration by adding a style property and value.
    public func style(_ style: Property) -> Self {
        var copy = self
        copy.styles.append(style)
        return copy
    }

    /// Returns a new configuration by adding a raw CSS property/value pair.
    func style(_ property: String, _ value: String?) -> Self {
        guard let value else { return self }
        var copy = self
        copy.styles.append(.custom(property, value: value))
        return copy
    }
}
