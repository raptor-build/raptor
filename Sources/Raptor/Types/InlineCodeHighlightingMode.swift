//
// InlineCodeHighlightingMode.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

/// Controls whether inline code should be syntax highlighted.
public enum InlineCodeHighlightingMode: Equatable, Sendable {
    /// Inline code will be highlighted using the configured syntax highlighter.
    case enabled
    /// Inline code will be rendered without syntax highlighting.
    case disabled
}
