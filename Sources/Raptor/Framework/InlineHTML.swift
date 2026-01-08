//
// InlineHTML.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

/// A type that represents the HTML representation of `InlineElement`.
public struct InlineHTML<Content: InlineContent>: HTML {
    /// The body of this HTML element.
    public var body: Never { fatalError() }

    /// The standard set of control attributes for HTML elements.
    public var attributes = CoreAttributes()

    /// The underlying HTML content, unattributed.
    private var content: Content

    /// The underlying HTML content, attributed.
    private var attributedContent: Content {
        var content = content
        content.attributes.merge(attributes)
        return content
    }

    /// The stable ID of the element.
    public var stableID: String? {
        content.stableID
    }

    /// Creates a new `InlineHTML` instance that wraps the given HTML content.
    /// - Parameter content: The HTML content to wrap
    init(_ content: Content) {
        self.content = content
    }

    /// Renders this element into HTML.
    /// - Returns: The rendered HTML markup.
    public func render() -> Markup {
        attributedContent.render()
    }
}
