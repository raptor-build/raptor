//
// PopoverAnchor.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

/// An anchor positioning option for popovers
public enum PopoverAnchor: Sendable {
    case top
    case bottom
    case left
    case right
    case topLeading
    case topTrailing
    case bottomLeading
    case bottomTrailing
    case center

    var positionClass: String {
        switch self {
        case .top: "popover-anchor-top"
        case .bottom: "popover-anchor-bottom"
        case .left: "popover-anchor-left"
        case .right: "popover-anchor-right"
        case .topLeading: "popover-anchor-top-left"
        case .topTrailing: "popover-anchor-top-right"
        case .bottomLeading: "popover-anchor-bottom-left"
        case .bottomTrailing: "popover-anchor-bottom-right"
        case .center: "popover-anchor-center"
        }
    }
}
