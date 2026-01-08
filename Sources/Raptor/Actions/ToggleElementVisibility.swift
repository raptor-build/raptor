//
// ToggleElementVisibility.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

import Foundation

/// Toggles an element's visibility by adding or removing the "d-none" CSS class.
public struct ToggleElementVisibility: Action {
    /// The unique identifiers of the elements we're trying to show/hide.
    private var ids: [String]

    /// Creates a new `ToggleElementVisibility` action from a specific page element ID.
    /// - Parameter id: The unique identifier of the element we're trying to show/hide.
    public init(_ id: String) {
        self.ids = [id]
    }

    /// Creates a new `ToggleElementVisibility` action from a specific page element ID.
    /// - Parameter id: The unique identifiers of the elements we're trying to show/hide.
    public init(_ ids: String...) {
        self.ids = ids
    }

    /// Creates a new `ToggleElementVisibility` action from a specific page element ID.
    /// - Parameter id: The unique identifiers of the elements we're trying to show/hide.
    public init(_ ids: [String]) {
        self.ids = ids
    }

    public func compile() -> String {
        let selector = ids.map { "#\($0)" }.joined(separator: ", ")
        return """
        document.querySelectorAll('\(selector)')
          .forEach(el => el.classList.toggle('d-none'));
        """
    }
}

public extension Action where Self == ToggleElementVisibility {
    /// Creates a new `ToggleElementVisibility` action
    /// - Parameter id: The unique identifier of the element whose visibility will be toggled
    /// - Returns: A `ToggleElementVisibility` action configured with the specified element ID
    static func toggleElementVisibility(_ id: String) -> Self {
        ToggleElementVisibility(id)
    }

    /// Creates a new `ToggleElementVisibility` action
    /// - Parameter ids: The unique identifiers of the elements whose visibility will be toggled
    /// - Returns: A `ToggleElementVisibility` action configured with the specified element ID
    static func toggleElementVisibility(_ ids: String...) -> Self {
        ToggleElementVisibility(ids)
    }
}
