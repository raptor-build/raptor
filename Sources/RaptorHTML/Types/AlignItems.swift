//
// AlignItems.swift
// RaptorHTML
// https://raptor.build
// See LICENSE for license information.
//

/// Defines how flex or grid items are aligned along the cross axis within a container.
public enum AlignItems: String, Sendable, CustomStringConvertible {
    /// Aligns items to the start of the cross axis.
    case flexStart = "flex-start"
    /// Aligns items to the end of the cross axis.
    case flexEnd = "flex-end"
    /// Aligns items to the container’s cross-axis center.
    case center
    /// Aligns items based on their baseline.
    case baseline
    /// Stretches items to fill the container’s cross axis.
    case stretch
    /// Modern logical keyword for start alignment.
    case start
    /// Modern logical keyword for end alignment.
    case end

    public var description: String { rawValue }
    var css: String { rawValue }
}
