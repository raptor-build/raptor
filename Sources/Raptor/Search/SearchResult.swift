//
// SearchResult.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

/// A template for displaying individual search results.
public struct SearchResult: Sendable {
    /// The title of the search result.
    public let title: Text = Text(verbatim: "").class("result-title")

    /// A brief description or excerpt of the search result content.
    public let description: Text = Text(verbatim: "").class("result-description")

    /// The publication date of the content.
    public let date: Text? = Text(verbatim: "").class("result-date")

    /// Optional tags associated with the search result.
    public let tags: Text? = Text(verbatim: "").class("result-tags")
}

private extension Text {
    func `class`(_ name: String) -> Self {
        var copy = self
        copy.attributes.append(classes: name)
        return copy
    }
}
