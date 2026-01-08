//
// JustifySelf.swift
// RaptorHTML
// https://raptor.build
// See LICENSE for license information.
//

/// Defines how a single grid or flex item is aligned along the inline axis within its container.
public enum JustifySelf: String, Sendable {
    /// Aligns the item based on the container's default alignment.
    case auto
    /// Aligns the item to the start of its container.
    case start
    /// Aligns the item to the end of its container.
    case end
    /// Centers the item along the inline axis.
    case center
    /// Stretches the item to fill its allocated space.
    case stretch

    /// The CSS string representation of the justify-self value.
    var css: String { rawValue }
}
