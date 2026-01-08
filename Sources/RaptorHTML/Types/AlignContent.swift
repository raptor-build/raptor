//
// AlignContent.swift
// RaptorHTML
// https://raptor.build
// See LICENSE for license information.
//

/// Defines alignment of multiple flex lines or grid rows when there is extra space.
public enum AlignContent: CustomStringConvertible, Sendable {
    case flexStart, flexEnd, center, spaceBetween, spaceAround, stretch

    public var description: String {
        switch self {
        case .flexStart: "flex-start"
        case .flexEnd: "flex-end"
        case .center: "center"
        case .spaceBetween: "space-between"
        case .spaceAround: "space-around"
        case .stretch: "stretch"
        }
    }

    var css: String { description }
}
