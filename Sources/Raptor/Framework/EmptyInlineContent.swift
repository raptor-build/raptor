//
// EmptyInlineElement.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

/// A placeholder element that renders nothing
/// Used as a default or fallback when no content is needed
public struct EmptyInlineContent: InlineContent {
    /// Creates a new empty element
    public nonisolated init() {}

    /// Returns self as the body content since this is an empty element
    public var body: Never { fatalError() }

    /// Renders this element as an empty string
    /// - Returns: An empty string
    public func render() -> Markup {
        Markup()
    }
}
