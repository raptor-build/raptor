//
// ScrollForward.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

/// Scrolls a scroll view to the next slide
public struct ScrollForward: Action, Sendable {
    /// The unique identifier of the scroll view to scroll
    private let scrollViewID: String

    /// Creates a new `ScrollForward` action
    /// - Parameter scrollViewID: The unique identifier of the scroll view
    public init(in scrollViewID: String) {
        self.scrollViewID = scrollViewID
    }

    /// Renders this action into JS.
    /// - Returns: The JavaScript for this action.
    public func compile() -> String {
        """
        window.RaptorScroll?.forward('\(scrollViewID)');
        """
    }
}

public extension Action where Self == ScrollForward {
    /// Creates a new `ScrollForward` action
    /// - Parameter scrollViewID: The unique identifier of the scroll view to scroll.
    /// - Returns: A `ScrollForward` action configured with the specified element ID
    static func scrollForward(in scrollViewID: String) -> Self {
        ScrollForward(in: scrollViewID)
    }
}
