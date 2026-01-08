//
// PageBreak.swift
// RaptorHTML
// https://raptor.build
// See LICENSE for license information.
//

/// Defines how page or column breaks should be applied before, after, or inside an element.
///
/// Commonly used in print styles or multi-column layouts.
public enum PageBreak: String, Sendable, Hashable {
    /// Default behavior determined by the user agent.
    case auto
    /// Always force a page or column break.
    case always
    /// Avoid creating a page or column break.
    case avoid
    /// Force a page break so the next page starts on the left side.
    case left
    /// Force a page break so the next page starts on the right side.
    case right

    var css: String { rawValue }
}
