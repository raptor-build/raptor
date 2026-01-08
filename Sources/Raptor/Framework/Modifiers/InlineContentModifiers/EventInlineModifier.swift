//
// EventInlineModifier.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

/// A modifier that adds event handling to inline elements.
private struct EventInlineModifier: InlineContentModifier {
    /// The type of event to handle.
    var type: EventType
    /// The actions to execute when the event occurs.
    var actions: [Action]

    /// Creates the modified inline element with event handling.
    /// - Parameter content: The content to modify.
    /// - Returns: The modified inline element with event attributes.
    func body(content: Content) -> some InlineContent {
        var content = content
        guard !actions.isEmpty else { return content }
        content.attributes.events.append(Event(type, actions: actions))
        return content
    }
}

public extension InlineContent {
    /// Adds an event attribute to the `InlineHTML` element.
    /// - Parameters:
    ///   - type: The name of the attribute.
    ///   - actions: Array of actions to execute when the event occurs
    /// - Returns: A modified HTML element with the specified attribute.
    func onEvent(_ type: EventType, _ actions: [Action]) -> some InlineContent {
        modifier(EventInlineModifier(type: type, actions: actions))
    }
}
