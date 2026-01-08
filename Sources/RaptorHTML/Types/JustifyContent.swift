//
// JustifyContent.swift
// RaptorHTML
// https://raptor.build
// See LICENSE for license information.
//

/// Defines alignment of flex or grid items along the main axis.
public enum JustifyContent: CustomStringConvertible, Sendable {
    case flexStart, flexEnd, center, spaceBetween, spaceAround, spaceEvenly
    case start, end, left, right, stretch

    public var description: String {
        switch self {
        case .flexStart: "flex-start"
        case .flexEnd: "flex-end"
        case .center: "center"
        case .spaceBetween: "space-between"
        case .spaceAround: "space-around"
        case .spaceEvenly: "space-evenly"
        case .start: "start"
        case .end: "end"
        case .left: "left"
        case .right: "right"
        case .stretch: "stretch"
        }
    }

    var css: String { description }
}
