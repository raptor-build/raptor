//
// DismissPopover.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

/// Shows a popover with the content of the page element identified by ID
public struct DismissPopover: Action, Sendable {
    /// The unique identifier of the element to display as a popover.
    private let id: String

    /// Creates a new `DismissPopover` action from a specific page element ID.
    /// - Parameters:
    ///   - id: The unique identifier of the element we're trying to show as a popover.
    public init(_ id: String) {
        self.id = id
    }

    /// Renders this action into JS.
    /// - Returns: The JavaScript for this action.
    public func compile() -> String {
        """
        closePopover('\(id)');
        """
    }
}

public extension Action where Self == DismissPopover {
    /// Creates a new `DismissPopover` action
    /// - Parameter id: The unique identifier of the modal to dismiss
    /// - Returns: A `DismissPopover` action configured with the specified modal ID
    static func dismissPopover(_ id: String) -> Self {
        DismissPopover(id)
    }
}
