//
// DismissModal.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

/// Dismiss a modal dialog with the content of the page element identified by ID
public struct DismissModal: Action {
    /// The unique identifier of the element of the modal we're trying to dismiss.
    private var id: String

    /// Creates a new `DismissModal` action from a specific page element ID.
    /// - Parameter id: The unique identifier of the element of the modal we're trying to dismiss.
    public init(_ id: String) {
        self.id = id
    }

    /// Renders this action into JS.
    /// - Returns: The JavaScript for this action.
    public func compile() -> String {
        """
        closeModal('\(id)');
        """
    }
}

public extension Action where Self == DismissModal {
    /// Creates a new `DismissModal` action
    /// - Parameter id: The unique identifier of the modal to dismiss
    /// - Returns: A `DismissModal` action configured with the specified modal ID
    static func dismissModal(_ id: String) -> Self {
        DismissModal(id)
    }
}
