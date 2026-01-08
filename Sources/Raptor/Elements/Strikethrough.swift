//
// Strikethrough.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

/// Renders text with a strikethrough effect.
public struct Strikethrough<Content: InlineContent>: InlineContent {
    /// The content and behavior of this HTML.
    public var body: Never { fatalError() }

    /// The standard set of control attributes for HTML elements.
    public var attributes = CoreAttributes()

    /// The content that should be stricken.
    private var content: Content

    /// Creates a new `Strikethrough` instance using an inline element builder
    /// that returns an array of content to place inside.
    public init(@InlineContentBuilder content: () -> Content) {
        self.content = content()
    }

    /// Creates a new `Strikethrough` instance using one `InlineElement`
    /// that should be rendered with a strikethrough effect.
    /// - Parameter singleElement: The element to strike.
    public init(_ key: String) where Content == String {
        self.content = Localizer.string(key, locale: Self.locale)
    }

    /// Renders this element into HTML.
    /// - Returns: The HTML for this element.
    public func render() -> Markup {
        let contentHTML = content.markupString()
        return Markup("<s\(attributes)>\(contentHTML)</s>")
    }
}
