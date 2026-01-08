//
// ScrollBackward.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

/// Scrolls a scroll view to the previous slide
public struct ScrollBackward: Action, Sendable {
    /// The unique identifier of the scroll view to scroll
    private let scrollViewID: String

    /// Creates a new `ScrollBackward` action
    /// - Parameter scrollViewID: The unique identifier of the scroll view
    public init(in scrollViewID: String) {
        self.scrollViewID = scrollViewID
    }

    /// Renders this action into JS.
    /// - Returns: The JavaScript for this action.
    public func compile() -> String {
        """
        window.RaptorScroll?.backward('\(scrollViewID)');
        """
    }
}

public extension Action where Self == ScrollBackward {
    /// Creates a new `ScrollBackward` action
    /// - Parameter scrollViewID: The unique identifier of the scroll view to scroll.
    /// - Returns: A `ScrollBackward` action configured with the specified element ID
    static func scrollBackward(in scrollViewID: String) -> Self {
        ScrollBackward(in: scrollViewID)
    }
}
