//
// ScrollTo.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

/// Scrolls a scroll view to a specific slide by index
public struct ScrollTo: Action, Sendable {
    /// The unique identifier of the scroll view to scroll
    private let id: String

    /// The index of the slide to scroll to
    private let index: Int

    /// Creates a new ScrollToSlide action
    /// - Parameters:
    ///   - index: The index of the slide to scroll to (0-based)
    ///   - scrollViewID: The unique identifier of the scroll view
    public init(index: Int, in scrollViewID: String) {
        self.id = scrollViewID
        self.index = index
    }

    /// Renders this action into JS.
    /// - Returns: The JavaScript for this action.
    public func compile() -> String {
        """
        window.RaptorScroll?.to('\(id)', \(index));
        """
    }
}

public extension Action where Self == ScrollTo {
    /// Creates a new `ScrollTo` action
    /// - Parameters:
    ///  - index: The index of the view to scroll to.
    ///  - scrollViewID: The unique identifier of the scroll view to scroll.
    /// - Returns: A `ScrollTo` action configured with the specified element ID
    static func scroll(to index: Int, in scrollViewID: String) -> Self {
        ScrollTo(index: index, in: scrollViewID)
    }
}
