//
// HoverInlineModifier.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

/// A modifier that adds hover event handling to inline HTML elements.
struct HoverInlineModifier: InlineContentModifier {
    var hover: [Action]
    var unhover: [Action]
    func body(content: Content) -> some InlineContent {
        content
            .onEvent(.mouseOver, hover)
            .onEvent(.mouseOut, unhover)
    }
}

public extension InlineContent {
    /// Adds "onmouseover" and "onmouseout" JavaScript events to this inline element.
    /// - Parameter actions: A closure that takes a Boolean indicating hover state and returns actions to execute.
    /// - Returns: A modified inline HTML element with the hover event handlers attached.
    func onHover(@ActionBuilder actions: (_ isHovering: Bool) -> [Action]) -> some InlineContent {
        modifier(HoverInlineModifier(hover: actions(true), unhover: actions(false)))
    }
}
