//
// PresentationAlignment.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

/// An alignment option for popovers
public enum PresentationAlignment: String, CaseIterable, Sendable {
    case top
    case bottom
    case left
    case right
    case topLeading
    case topTrailing
    case bottomLeading
    case bottomTrailing
    case leading
    case trailing
    case center

    var cssClass: String {
        "presentation-align-\(rawValue)"
    }
}
