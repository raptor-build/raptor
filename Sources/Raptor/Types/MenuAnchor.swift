//
// MenuAnchor.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

/// An alignment option for menus
public enum MenuAnchor: String, CaseIterable {
    case top
    case bottom
    case leading
    case trailing
    case topLeading
    case topTrailing
    case bottomLeading
    case bottomTrailing
    case center

    var cssClass: String {
        "dropdown-align-\(rawValue)"
    }

    /// The direction the dropdown carrot should point
    var carrotDirection: CarrotDirection {
        switch self {
        case .top, .topLeading, .topTrailing: .up
        case .bottom, .bottomLeading, .bottomTrailing: .down
        case .leading: .left
        case .trailing: .right
        case .center: .none
        }
    }
}

/// A simple helper enum for carrot orientation
enum CarrotDirection: String {
    case up
    case down
    case left
    case right
    case none

    /// Optional: CSS class for carrot direction
    var cssClass: String {
        "carrot-\(rawValue)"
    }
}
