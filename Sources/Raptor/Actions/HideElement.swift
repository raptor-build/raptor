//
// HideElement.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

/// Hides a page element by appending the "d-none" CSS class.
public struct HideElement: Action {
    /// The unique identifiers of the elements we're trying to hide.
    private var ids: [String]

    /// Creates a new `HideElement` action from a specific page element ID.
    /// - Parameter id: The unique identifier of the element we're trying to hide.
    public init(_ id: String) {
        self.ids = [id]
    }

    /// Creates a new `HideElement` action from a specific page element ID.
    /// - Parameter ids: The unique identifiers of the elements we're trying to hide.
    public init(_ ids: String...) {
        self.ids = ids
    }

    /// Creates a new `HideElement` action from a specific page element ID.
    /// - Parameter ids: The unique identifiers of the elements we're trying to hide.
    public init(_ ids: [String]) {
        self.ids = ids
    }

    /// Renders this action into JS.
    /// - Returns: The JavaScript for this action.
    public func compile() -> String {
        let selector = ids.map { "#\($0)" }.joined(separator: ", ")
        return """
        document.querySelectorAll('\(selector)')
          .forEach(el => el.classList.add('d-none'));
        """
    }
}

public extension Action where Self == HideElement {
    /// Creates a new `HideElement` action
    /// - Parameter id: The unique identifier of the element to hide
    /// - Returns: A `HideElement` action configured with the specified element ID
    static func hideElement(_ id: String) -> Self {
        HideElement(id)
    }

    /// Creates a new `HideElement` action
    /// - Parameter ids: The unique identifiers of the elements to hide
    /// - Returns: A `HideElement` action configured with the specified element ID
    static func hideElement(_ ids: String...) -> Self {
        HideElement(ids)
    }
}
