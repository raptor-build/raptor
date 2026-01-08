//
// Event.swift
// RaptorHTML
// https://raptor.build
// See LICENSE for license information.
//

/// One event that can trigger a series of actions, such as
/// an onClick event hiding an element on the page.
package struct Event: Sendable, Hashable, Comparable {
    package var name: String
    package var actions: [any Action]

    package static func == (lhs: Event, rhs: Event) -> Bool {
        rhs.name == lhs.name &&
        rhs.actions.map { $0.compile() } == lhs.actions.map { $0.compile() }
    }

    package static func < (lhs: Event, rhs: Event) -> Bool {
        lhs.name < rhs.name
    }

    package init(_ type: EventType, actions: [any Action]) {
        self.name = type.rawValue
        self.actions = actions
    }

    package init(name: String, actions: [any Action]) {
        self.name = name
        self.actions = actions
    }

    package func hash(into hasher: inout Hasher) {
        hasher.combine(name)
        hasher.combine(actions.map { $0.compile() })
    }
}
