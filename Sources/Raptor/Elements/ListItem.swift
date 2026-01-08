//
// ListItem.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

/// Creates one item in a list. This isn't always needed, because you can place other
/// elements directly into lists if you wish. Use `ListItem` when you specifically
/// need a styled HTML <li> element.
struct ListItem<Content: HTML>: HTML {
    /// The content and behavior of this HTML.
    var body: Never { fatalError() }

    /// The standard set of control attributes for HTML elements.
    var attributes = CoreAttributes()

    /// The content of this list item.
    private var content: Content

    /// Creates a new `ListItem` object using an inline element builder that
    /// returns an array of `HTML` objects to display in the list.
    /// - Parameter content: The content you want to display in your list.
    init(@HTMLBuilder content: () -> Content) {
        self.content = content()
    }

    /// Creates a new `ListItem` object from a piece of HTML content.
    /// - Parameter content: The content you want to display in your list.
    init(_ content: Content) {
        self.content = content
    }

    /// Creates a new `ListItem` object from a piece of HTML content.
    /// - Parameter content: The content you want to display in your list.
    init<T: InlineContent>(_ content: T) where Content == InlineHTML<T> {
        self.content = InlineHTML(content)
    }

    /// Renders this element into HTML.
    /// - Returns: The HTML for this element.
    func render() -> Markup {
        let contentHTML = content.markupString()
        return Markup("<li\(attributes)>\(contentHTML)</li>")
    }
}
