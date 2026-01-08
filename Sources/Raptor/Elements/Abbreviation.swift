//
// Abbreviation.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

/// Renders an abbreviation.
public struct Abbreviation<Content: InlineContent>: InlineContent {
    /// The content and behavior of this HTML.
    public var body: Never { fatalError() }

    /// The standard set of control attributes for HTML elements.
    public var attributes = CoreAttributes()

    /// The content of this abbreviation.
    private var content: Content

    /// Creates a new `Abbreviation` instance.
    /// - Parameter abbreviationKey: The abbreviation.
    /// - Parameter description: The description of the abbreviation.
    public init(_ abbreviationKey: String, description: String) where Content == String {
        self.content = Localizer.string(abbreviationKey, locale: Self.locale)
        attributes.append(customAttributes: .init(name: "title", value: description))
    }

    /// Creates a new `Abbreviation` instance using an inline element builder
    /// that returns an array of content to place inside.
    /// - Parameters:
    ///   - description: The description of the abbreviation.
    ///   - content: The elements to place inside the abbreviation.
    public init(_ description: String, @InlineContentBuilder content: () -> Content) {
        self.content = content()
        attributes.append(customAttributes: .init(name: "title", value: description))
    }

    /// Renders this element into HTML.
    /// - Returns: The HTML for this element.
    public func render() -> Markup {
        let contentHTML = content.markupString()
        return Markup("<abbr\(attributes)>\(contentHTML)</abbr>")
    }
}
