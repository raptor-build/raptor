//
// SearchTextHighlightingDisabledModifier.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

public extension HTML {
    /// Disables automatic highlighting of search terms in search results.
    func searchResultHighlightingDisabled() -> some HTML {
        self.data("search-highlighting", "false")
    }
}

public extension InlineContent {
    /// Disables automatic highlighting of search terms in search results.
    func searchResultHighlightingDisabled() -> some InlineContent {
        self.data("search-highlighting", "false")
    }
}
