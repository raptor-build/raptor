//
// ObjectFit.swift
// RaptorHTML
// https://raptor.build
// See LICENSE for license information.
//

/// Defines how replaced content (like images or videos) should fit within its container.
public enum ObjectFit: String, Sendable, Hashable {
    /// Content is resized to fill the box, possibly distorting the aspect ratio.
    case fill
    /// Content is scaled to maintain its aspect ratio while fitting inside the box.
    case contain
    /// Content is scaled to maintain its aspect ratio while covering the entire box.
    case cover
    /// Content is not resized.
    case none
    /// Content is scaled down to the smallest possible size while maintaining its aspect ratio.
    case scaleDown = "scale-down"

    var css: String { rawValue }
}
