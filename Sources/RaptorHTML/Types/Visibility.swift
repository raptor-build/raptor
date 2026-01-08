//
// Visibility.swift
// RaptorHTML
// https://raptor.build
// See LICENSE for license information.
//

/// Defines whether an element is visible or not.
public enum Visibility: CustomStringConvertible, Sendable {
    case visible, hidden, collapse

    public var description: String {
        switch self {
        case .visible: "visible"
        case .hidden: "hidden"
        case .collapse: "collapse"
        }
    }

    var css: String { description }
}
