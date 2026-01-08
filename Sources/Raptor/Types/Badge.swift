//
// Badge.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

/// A small, capsule-shaped piece of information, such as a tag.
public struct Badge<Content: InlineContent>: InlineContent {
    /// The content and behavior of this HTML.
    public var body: Never { fatalError() }

    /// The standard set of control attributes for HTML elements.
    public var attributes = CoreAttributes()

    private var content: Content
    private var style = BadgeStyle.automatic

    private var badgeClasses: [String] {
        var outputClasses = ["badge"]
        outputClasses.append("badge-\(style.rawValue)")
        outputClasses.append("badge-pill")
        return outputClasses
    }

    public init(_ content: Content) {
        self.content = content
    }

    public init(_ content: String) where Content == String {
        self.content = content
    }

    public func badgeStyle(_ style: BadgeStyle) -> Self {
        var copy = self
        copy.style = style
        return copy
    }

    /// Renders this element into HTML.
    /// - Returns: The HTML for this element.
    public func render() -> Markup {
        let badgeAttributes = attributes.appending(classes: badgeClasses)
        return InlineText(content)
            .attributes(badgeAttributes)
            .render()
    }
}
