//
// LinkGroup.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

import Foundation

/// A hyperlink to another resource on this site or elsewhere.
public struct LinkGroup<Content: HTML>: HTML {
    /// The content and behavior of this HTML.
    public var body: Never { fatalError() }

    /// The standard set of control attributes for HTML elements.
    public var attributes = CoreAttributes()

    /// The content to display inside this link.
    private var content: Content

    /// The location to which this link should direct users.
    private var url: String

    /// Creates a `Link` instance from the content you provide, linking to the
    /// URL specified.
    /// - Parameters:
    ///   - destination: The URL you want to link to.
    ///   - content: The user-facing content to show inside the `Link`.
    public init(destination: String, @HTMLBuilder content: () -> Content) {
        self.content = content()
        self.url = destination
    }

    /// Creates a Link wrapping the provided content and pointing to the given page
    /// - Parameters:
    ///  - destination: The new target to apply.
    ///  - content: The user-facing content to show inside the `Link`.
    public init(destination: any Page, @HTMLBuilder content: () -> Content) {
        self.content = content()
        self.url = destination.path
    }

    /// Creates a `Link` wrapping the provided content and pointing to the path
    /// of the `Post` instance you provide.
    /// - Parameters:
    ///   - post: A post from your site.
    ///   - content: The user-facing content to show inside the `Link`.
    public init(destination post: Post, @HTMLBuilder content: () -> Content) {
        self.content = content()
        self.url = post.path
    }

    /// Controls in which window this page should be opened.
    /// - Parameter destination: The new destination to apply.
    /// - Returns: A new `Link` instance with the updated target.
    public func linkOpenBehavior(_ destination: LinkOpenBehavior) -> Self {
        if let name = destination.name {
            var copy = self
            let attribute = Attribute(name: "target", value: name)
            copy.attributes.append(customAttributes: attribute)
            return copy
        } else {
            return self
        }
    }

    /// Sets one or more relationships for this link, which provides metadata
    /// describing what this content means or how it should be used.
    /// - Parameter relationship: The extra relationships to add.
    /// - Returns: A new `Link` instance with the updated relationships.
    public func relationship(_ relationship: LinkRelationship...) -> Self {
        var copy = self
        let attributeValue = relationship.map(\.rawValue).joined(separator: " ")
        let attribute = Attribute(name: "rel", value: attributeValue)
        copy.attributes.append(customAttributes: attribute)
        return copy
    }

    /// Renders this element into HTML.
    /// - Returns: The HTML for this element.
    public func render() -> Markup {
        isPrivacySensitive
            ? renderPrivacyProtectedLink()
            : renderStandardLink()
    }

    /// Whether this link contains sensitive content that should be protected
    private var isPrivacySensitive: Bool {
        attributes.customAttributes.contains { $0.name == "privacy-sensitive" }
    }

    /// Renders a link with privacy protection enabled, encoding the URL and optionally the display content.
    /// - Returns: An HTML anchor tag with encoded attributes and content.
    private func renderPrivacyProtectedLink() -> Markup {
        let displayText = content.markupString()
        let encodingType = attributes.customAttributes.first { $0.name == "privacy-sensitive" }?.value ?? "urlOnly"

        let encodedUrl = Data(url.utf8).base64EncodedString()
        let displayContent = switch encodingType {
        case "urlAndDisplay": Data(displayText.utf8).base64EncodedString()
        default: displayText
        }

        var linkAttributes = attributes.appending(classes: "link-plain", "d-inline-block")
        linkAttributes.append(classes: "protected-link")
        linkAttributes.append(dataAttributes: .init(name: "encoded-url", value: encodedUrl))
        linkAttributes.append(customAttributes: .init(name: "href", value: "#"))

        return Markup("a\(linkAttributes)>\(displayContent)</a>")
    }

    /// Renders a standard link with the provided URL and content.
    /// - Returns: An HTML anchor tag with the appropriate href and content.
    private func renderStandardLink() -> Markup {
        var linkAttributes = attributes.appending(classes: "link-plain", "d-inline-block")

        guard let url = URL(string: url) else {
            BuildContext.logWarning("One of your links uses an invalid URL.")
            return Markup()
        }

        let path = renderingContext.path(for: url)
        linkAttributes.append(customAttributes: .init(name: "href", value: path))
        let contentHTML = content.markupString()
        return Markup("<a\(linkAttributes)>\(contentHTML)</a>")
    }
}
