//
// ShowElement.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

/// Shows a page element by removing the "d-none" CSS class.
public struct ShowElement: Action {
    /// The unique identifiers of the elements we're trying to hide.
    private let ids: [String]

    /// Creates a new `ShowElement` action from a specific page element ID.
    /// - Parameter id: The unique identifier of the element we're trying to hide.
    public init(_ id: String) {
        self.ids = [id]
    }

    /// Creates a new `ShowElement` action from a specific page element ID.
    /// - Parameter ids: The unique identifiers of the elements we're trying to hide.
    public init(_ ids: String...) {
        self.ids = ids
    }

    /// Creates a new `ShowElement` action from a specific page element ID.
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
          .forEach(el => el.classList.remove('d-none'));
        """
    }
}

public extension Action where Self == ShowElement {
    /// Creates a new `ShowElement` action
    /// - Parameter id: The unique identifier of the element to show
    /// - Returns: A `ShowElement` action configured with the specified element ID
    static func showElement(_ id: String) -> Self {
        ShowElement(id)
    }

    /// Creates a new `ShowElement` action
    /// - Parameter ids: The unique identifiers of the elements to show
    /// - Returns: A `ShowElement` action configured with the specified element ID
    static func showElement(_ ids: String...) -> Self {
        ShowElement(ids)
    }
}
