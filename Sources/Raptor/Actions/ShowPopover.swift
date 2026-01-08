//
// ShowPopover.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

/// Shows a popover with the content of the page element identified by ID
public struct ShowPopover: Action, Sendable {
    /// The unique identifier of the element to display as a popover.
    private let id: String

    /// Creates a new `ShowPopover` action from a specific page element ID.
    /// - Parameters:
    ///   - id: The unique identifier of the element we're trying to show as a popover.
    public init(_ id: String) {
        self.id = id
    }

    /// Renders this action into JS.
    /// - Returns: The JavaScript for this action.
    public func compile() -> String {
        """
        openPopover('\(id)', this);
        """
    }
}

public extension Action where Self == ShowPopover {
    /// Creates a new `ShowPopover` action
    /// - Parameter id: The unique identifier of the modal to dismiss
    /// - Returns: A `ShowPopover` action configured with the specified modal ID
    static func showPopover(_ id: String) -> Self {
        ShowPopover(id)
    }
}
