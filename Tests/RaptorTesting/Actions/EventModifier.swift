//
//  EventModifier.swift
//  Raptor
//  https://raptor.build
//  See LICENSE for license information.
//

import Foundation
import Testing

@testable import Raptor

/// Tests for the `EventModifier` action.
@Suite("EventModifier Tests")
struct EventModifierTests {
    private static let tags: [String] = ["body", "btn", "img", "div", "section"]

    private static let events: [EventType] = [
        .click,
        .doubleClick,
        .focus,
        .load,
        .mouseOver
    ]

    private static let actions: [[Action]] = [
        [ShowAlert(message: "foo")],
        [ShowAlert(message: "qux"), DismissModal("baz")],
        [CustomAction("document.writeline('bar')")],
        [CustomAction("document.writeline('foo')"), ShowElement("qux")],
        [ShowModal("foo"), HideElement("qux")]
    ]

    @Test("Events are added", arguments: tags, Array(zip(events, actions)))
    func eventsAdded(tag: String, eventActions: (EventType, [any Action])) {
        let element = Tag(tag) {}
            .onEvent(eventActions.0, eventActions.1)

        let output = element.render()

        let eventOutput = eventActions.0.rawValue
        let actionOutput = eventActions.1.map { $0.compile() }.joined(separator: "; ")

        #expect(output.string == "<\(tag) \(eventOutput)=\"\(actionOutput)\"></\(tag)>")
    }
}
