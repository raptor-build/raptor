//
// DropdownItemHoverEffect.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

/// Describes the visual effect applied when a dropdown item is hovered.
public enum DropdownItemHoverEffect: Sendable, Hashable {
    /// Applies a background color when the dropdown item is hovered.
    case tint(Color)

    /// Converts the hover effect into its corresponding CSS property.
    var styleProperty: Property {
        switch self {
        case .tint(let color):
            .variable("dropdown-hover-bg", value: color.description)
        }
    }
}
