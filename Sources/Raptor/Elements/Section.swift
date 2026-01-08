//
// Section.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

/// A container element that groups its children together.
///
/// When initialized with just content, the section wraps its children in a `<div>`.
/// When initialized with a header and content, the section wraps its children in a `<section>`.
///
/// - Note: Unlike ``Group``, modifiers applied to a `Section` affect the
///         containing element rather than being propagated to child elements.
public struct Section<Content> {
    /// The content and behavior of this HTML.
    public var body: Never { fatalError() }

    /// The standard set of control attributes for HTML elements.
    public var attributes = CoreAttributes()

    /// The heading text of the section.
    private var header: String?

    /// The heading's semantic font size.
    private var headerStyle: Font.Style = .title2

    /// The content of the section.
    private var content: Content
}

extension Section: HTML where Content: HTML {
    /// Creates a section that renders as a `div` element.
    /// - Parameter content: The content to display within this section.
    public init(@HTMLBuilder content: () -> Content) {
        self.content = content()
    }

    /// Creates a section that renders as a `section` element with a heading.
    /// - Parameters:
    ///   - header: The text to display as the section's heading
    ///   - content: The content to display within this section
    public init(_ headerKey: String, @HTMLBuilder content: () -> Content) {
        self.content = content()
        self.header = Localizer.string(headerKey, locale: Self.locale)
    }

    init(_ content: Content) {
        self.content = content
    }

    init() where Content == EmptyHTML {
        self.content = EmptyHTML()
    }

    init<T: InlineContent>(_ content: T) where Content == InlineHTML<T> {
        self.content = InlineHTML(content)
    }

    /// Adjusts the semantic importance of the section's header by changing its font style.
    /// - Parameter fontStyle: The font style to apply to the header
    /// - Returns: A section with the modified header style
    public func headerProminence(_ fontStyle: Font.Style) -> Self {
        var copy = self
        copy.headerStyle = fontStyle
        return copy
    }

    public func render() -> Markup {
        let contentHTML = content.markupString()
        if let header = header {
            let headerHTML = Text(header).font(headerStyle).markupString()
            return Markup("<section\(attributes)>\(headerHTML + contentHTML)</section>")
        }
        return Markup("<div\(attributes)>\(contentHTML)</div>")
    }
}
