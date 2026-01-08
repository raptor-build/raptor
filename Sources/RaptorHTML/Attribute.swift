//
// Attribute.swift
// RaptorHTML
// https://raptor.build
// See LICENSE for license information.
//

/// A simple key-value pair of strings that is able to store custom attributes.
package struct Attribute: Hashable, Equatable, Sendable, Comparable, CustomStringConvertible {
    /// The attribute's name, e.g. "target" or "rel".
    package var name: String

    /// The attribute's value, e.g. "myFrame" or "stylesheet".
    package var value: String?

    package init(name: String, value: String) {
        self.name = name
        self.value = value
    }

    package init(_ name: String) {
        self.name = name
        self.value = nil
    }

    package var description: String {
        if let value {
            "\(name)=\"\(value)\""
        } else {
            name
        }
    }

    package static func < (lhs: Attribute, rhs: Attribute) -> Bool {
        lhs.description < rhs.description
    }
}
