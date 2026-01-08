//
// EventModifier.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

/// A modifier that adds event handling to HTML elements.
private struct EventModifier: HTMLModifier {
    /// The type of event to handle.
    var type: EventType
    /// The actions to execute when the event occurs.
    var actions: [Action]

    /// Applies event handling to the provided HTML content.
    /// - Parameter content: The HTML content to modify.
    /// - Returns: The modified HTML content with event handling attached.
    func body(content: Content) -> some HTML {
        var modified = content
        guard !actions.isEmpty else { return content }
        modified.attributes.events.append(Event(type, actions: actions))
        return modified
    }
}

public extension HTML {
    /// Adds an event attribute to the `HTML` element.
    /// - Parameters:
    ///   - type: The name of the attribute.
    ///   - actions: Array of actions to execute when the event occurs
    /// - Returns: A modified HTML element with the specified attribute.
    func onEvent(_ type: EventType, _ actions: [Action]) -> some HTML {
        modifier(EventModifier(type: type, actions: actions))
    }
}
