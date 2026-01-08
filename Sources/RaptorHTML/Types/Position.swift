//
// Position.swift
// RaptorHTML
// https://raptor.build
// See LICENSE for license information.
//

/// Defines how an element is positioned in the document flow.
public enum Position: CustomStringConvertible, Sendable {
    case staticPosition, relative, absolute, fixed, sticky

    public var description: String {
        switch self {
        case .staticPosition: "static"
        case .relative: "relative"
        case .absolute: "absolute"
        case .fixed: "fixed"
        case .sticky: "sticky"
        }
    }
}
