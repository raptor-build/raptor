//
// String.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

/// A small String extension that allows strings to be used directly inside HTML.
/// Useful when you don't want your text to be wrapped in a paragraph or similar.
extension String: InlineContent {
    /// The content and behavior of this HTML.
    public var body: Never { fatalError() }

    /// Renders this element into HTML.
    /// - Returns: The HTML for this element.
    public func render() -> Markup {
        Markup(self)
    }
}
