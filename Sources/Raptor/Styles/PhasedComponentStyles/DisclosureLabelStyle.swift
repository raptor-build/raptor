//
// DisclosureLabelStyle.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

public protocol DisclosureLabelStyle: PhasedComponentStyle where Phase == DisclosurePhase {
    /// The button configuration used to represent the current button state and styles.
    typealias Content = DisclosureLabelConfiguration
}

public extension DisclosureLabelStyle {
    static var id: String { "disc" }
}
