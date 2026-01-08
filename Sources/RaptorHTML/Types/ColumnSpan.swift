//
// ColumnSpan.swift
// RaptorHTML
// https://raptor.build
// See LICENSE for license information.
//

/// Defines how many columns an element should span.
public enum ColumnSpan: CustomStringConvertible, Sendable {
    case none, all

    public var description: String {
        switch self {
        case .none: "none"
        case .all: "all"
        }
    }
}
