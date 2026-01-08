//
// LineWrapping.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

/// Specifies how text lines wrap within a container.
public enum LineWrappingMode: String, Sendable, CaseIterable {
    /// Wraps lines naturally based on available space.
    case automatic = "wrap"

    /// Prevents line wrapping, keeping text on a single line.
    case none = "nowrap"

    /// Balances line lengths to produce more even wrapping.
    case balanceLines = "balance"

    /// Adjusts wrapping to avoid orphaned words on the last line.
    case preventOrphans = "pretty"

    /// Uses a fixed wrapping algorithm that remains stable across layout changes.
    case fixed = "stable"
}

public extension HTML {
    /// Controls how text lines wrap within this element.
    /// - Parameter lineWrapMode: The wrapping behavior to apply to the element’s text.
    /// - Returns: A view that applies the specified line-wrapping behavior.
    func lineWrapping(_ lineWrapMode: LineWrappingMode) -> some HTML {
        self.style(.custom("text-wrap", value: lineWrapMode.rawValue))
    }
}
