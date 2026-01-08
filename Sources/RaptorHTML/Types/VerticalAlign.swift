//
// VerticalAlign.swift
// RaptorHTML
// https://raptor.build
// See LICENSE for license information.
//

/// Defines how an inline or table-cell element is aligned
/// along the vertical axis, mapping directly to the CSS
/// `vertical-align` property.
public enum VerticalAlign: CustomStringConvertible, Sendable {
    case baseline
    case sub
    case `super`
    case textTop
    case textBottom
    case middle
    case top
    case bottom

    public var description: String {
        switch self {
        case .baseline:   "baseline"
        case .sub:        "sub"
        case .super:      "super"
        case .textTop:    "text-top"
        case .textBottom: "text-bottom"
        case .middle:     "middle"
        case .top:        "top"
        case .bottom:     "bottom"
        }
    }

    /// The raw CSS value.
    var css: String { description }
}
