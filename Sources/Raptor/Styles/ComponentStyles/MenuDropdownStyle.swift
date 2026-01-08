//
// MenuDropdownStyle.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

/// A protocol that defines a reusable visual style for dropdown menus.
public protocol MenuDropdownStyle: ComponentStyle {
    /// The configuration representing the dropdown’s current state and visual properties.
    typealias Content = MenuDropdownConfiguration

    /// A result builder used to compose dropdown styles declaratively.
    typealias StyleBuilder = MenuDropdownStyleBuilder
}
