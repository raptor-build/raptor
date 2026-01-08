//
// DropdownItemCornerStyle.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

/// Defines the visual corner style applied to dropdown menu items.
public enum DropdownItemCornerStyle: Hashable, Sendable {
    /// Dropdown items have rounded corners (default appearance).
    case rounded

    /// Dropdown items have square, sharp corners.
    case square

    /// Returns the CSS value corresponding to the corner style.
    var css: String? {
        switch self {
        case .rounded: nil
        case .square: "0"
        }
    }
}
