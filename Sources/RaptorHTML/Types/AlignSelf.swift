//
// AlignSelf.swift
// RaptorHTML
// https://raptor.build
// See LICENSE for license information.
//

/// Defines alignment of an individual flex item along the cross axis.
public enum AlignSelf: CustomStringConvertible, Sendable {
    case auto
    case flexStart
    case flexEnd
    case center
    case baseline
    case stretch
    case start
    case end

    public var description: String {
        switch self {
        case .auto: "auto"
        case .flexStart: "flex-start"
        case .flexEnd: "flex-end"
        case .center: "center"
        case .baseline: "baseline"
        case .stretch: "stretch"
        case .start: "start"
        case .end: "end"
        }
    }

    var css: String { description }
}
