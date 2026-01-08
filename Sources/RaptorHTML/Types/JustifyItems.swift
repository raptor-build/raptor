//
// JustifyItems.swift
// RaptorHTML
// https://raptor.build
// See LICENSE for license information.
//

/// Defines how items are aligned along the inline axis within a grid or flex container.
public enum JustifyItems: String, Sendable {
    /// Aligns items to the start of the container.
    case start
    /// Aligns items to the end of the container.
    case end
    /// Centers items along the inline axis.
    case center
    /// Stretches items to fill the container.
    case stretch

    /// The CSS string representation of the justify-items value.
    var css: String { rawValue }
}
