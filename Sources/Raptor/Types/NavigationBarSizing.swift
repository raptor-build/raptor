//
// NavigationBarSizing.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

public enum NavigationBarSizing: String, Sendable, Hashable, CaseIterable {
    /// Content is constrained to a readable width (like a centered container)
    case contentArea = "nav-width-content"

    /// Content spans full viewport width
    case window = "nav-width-viewport"
}
