//
// InlineText.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

/// An inline subsection of another element, useful when you need to style
/// just part of some text, for example.
public struct InlineText<Content: InlineContent>: InlineContent {
    /// The content and behavior of this HTML.
    public var body: Never { fatalError() }

    /// The standard set of control attributes for HTML elements.
    public var attributes = CoreAttributes()

    /// The content of this span.
    private var content: Content

    /// The HTML tag that corresponds to this element.
    private var tag = "span"

    /// Creates a span from one `InlineElement`.
    /// - Parameter singleElement: The element you want to place
    /// inside the span.
    init(_ singleElement: Content) {
        self.content = singleElement
    }

    /// Creates a span from one `InlineElement`.
    /// - Parameter singleElement: The element you want to place
    /// inside the span.
    public init(_ key: String) where Content == String {
        self.content = Localizer.string(key, locale: Self.locale)
    }

    /// Creates a literal, unlocalized text element.
    public init(verbatim string: String) where Content == String {
        self.content = string
    }

    /// Creates a span from an inline element builder that returns an array of
    /// elements to place inside the span.
    /// - Parameter contents: The elements to place inside the span.
    public init(@InlineContentBuilder content: () -> Content) {
        self.content = content()
    }

    /// Marks this text as having **strong importance**, transforming it into a semantic
    /// `<strong>` element rather than merely styling it as bold.
    ///
    /// This affects accessibility, document structure, and assistive technologies.
    /// If you only want to change visual weight without increasing semantic importance,
    /// use the `fontWeight(_:)` modifier instead.
    public func bold() -> Self {
        var copy = self
        copy.tag = "strong"
        return copy
    }

    /// Marks this text as **emphasized**, transforming it into a semantic `<em>` element
    /// that conveys stress or emphasis in the document’s structure.
    ///
    /// This goes beyond italic styling and is interpreted by screen readers and other
    /// semantic consumers of the document.
    public func italic() -> Self {
        var copy = self
        copy.tag = "em"
        return copy
    }

    /// Renders this element into HTML.
    /// - Returns: The HTML for this element.
    public func render() -> Markup {
        let contentHTML = content.markupString()
        return Markup("<\(tag)\(attributes)>\(contentHTML)</\(tag)>")
    }
}
