//
// CounterTypes.swift
// RaptorHTML
// https://raptor.build
// See LICENSE for license information.
//

/// Represents a CSS counter reset instruction.
///
/// Example:
/// ```swift
/// .counterReset(.custom("section", 0))
/// ```
public enum CounterReset: Sendable, Hashable {
    case none
    case custom(String, Int?)

    var css: String {
        switch self {
        case .none: return "none"
        case let .custom(name, value):
            if let value { return "\(name) \(value)" }
            return name
        }
    }
}

/// Represents a CSS counter increment instruction.
///
/// Example:
/// ```swift
/// .counterIncrement(.custom("section", 1))
/// ```
public enum CounterIncrement: Sendable, Hashable {
    case none
    case custom(String, Int?)

    var css: String {
        switch self {
        case .none: return "none"
        case let .custom(name, value):
            if let value { return "\(name) \(value)" }
            return name
        }
    }
}

/// Represents a CSS counter set instruction.
///
/// Example:
/// ```swift
/// .counterSet(.custom("section", 5))
/// ```
public enum CounterSet: Sendable, Hashable {
    case none
    case custom(String, Int?)

    var css: String {
        switch self {
        case .none: return "none"
        case let .custom(name, value):
            if let value { return "\(name) \(value)" }
            return name
        }
    }
}
