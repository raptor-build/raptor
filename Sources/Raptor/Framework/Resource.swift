//
// Resource.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

import Foundation

/// An item of metadata that links to an external resource somehow, such as
/// a stylesheet.
struct Resource: HeadContent, Sendable {
    /// The CSS responsible for applying CSS relating to animations and themes..
    static let raptorCoreCSS = Resource(href: "/css/raptor-core.css", rel: .stylesheet)

    /// The CSS used in Prism plugins like line numbering and line highlighting.
    static let prismCSS = Resource(href: "/css/prism.css", rel: .stylesheet)

    /// The highlighter theme variables used throughout the site.
    static let prismThemesCSS = Resource(href: "/css/prism-themes.css", rel: .stylesheet)

    /// The CSS you should include for Raptor pages that use system icons.
    static let iconCSS = Resource(href: "/css/bootstrap-icons.min.css", rel: .stylesheet)

    /// The standard set of control attributes for HTML elements.
    var attributes = CoreAttributes()

    /// The target of this link.
    var href: String

    /// The relationship of this link to the current page.
    private var rel: String

    /// Creates a new `MetaLink` object using the target and relationship provided.
    /// - Parameters:
    ///   - href: The location of the resource in question.
    ///   - rel: How this resource relates to the current page.
    init(href: String, rel: String) {
        self.href = href
        self.rel = rel
    }

    /// Creates a new `MetaLink` object using the target and relationship provided.
    /// - Parameters:
    ///   - href: The location of the resource in question.
    ///   - rel: How this resource relates to the current page.
    init(href: URL, rel: String) {
        self.href = href.absoluteString
        self.rel = rel
    }

    /// Creates a new `MetaLink` object using the target and relationship provided.
    /// - Parameters:
    ///   - href: The location of the resource in question.
    ///   - rel: How this resource relates to the current page.
    init(href: String, rel: LinkRelationship) {
        self.href = href
        self.rel = rel.rawValue
    }

    /// Creates a new `MetaLink` object using the target and relationship provided.
    /// - Parameters:
    ///   - href: The location of the resource in question.
    ///   - rel: How this resource relates to the current page.
    init(href: URL, rel: LinkRelationship) {
        self.href = href.absoluteString
        self.rel = rel.rawValue
    }

    /// Renders this element into HTML.
    /// - Returns: The HTML for this element.
    ///
    /// If the link `href` starts with a `\` it is an asset and requires any `subsite` prepended;
    /// otherwise the `href` is a URL and  doesn't get `subsite` prepended
    func render() -> Markup {
        var attributes = attributes
        // char[0] of the link 'href' is '/' for an asset; not for a site URL
        let basePath = href.starts(with: "/") ? renderingContext.site.url.path : ""
        attributes.append(customAttributes:
            .init(name: "href", value: "\(basePath)\(href)"),
            .init(name: "rel", value: rel))

        return Markup("<link\(attributes) />")
    }
}

extension Resource {
    /// Adds a data attribute to the element.
    /// - Parameters:
    ///   - name: The name of the data attribute
    ///   - value: The value of the data attribute
    /// - Returns: The modified `MetaLink`
    func data(_ name: String, _ value: String) -> Self {
        var copy = self
        copy.attributes.data.append(.init(name: name, value: value))
        return copy
    }

    /// Adds a custom attribute to the element.
    /// - Parameters:
    ///   - name: The name of the custom attribute
    ///   - value: The value of the custom attribute
    /// - Returns: The modified `HTML` element
    func attribute(_ name: String, _ value: String) -> Self {
        var copy = self
        copy.attributes.append(customAttributes: .init(name: name, value: value))
        return copy
    }

    /// Adds a custom attribute to the element.
    /// - Parameter name: The name of the boolean attribute to add
    /// - Returns: The modified `HTML` element
    func attribute(_ name: String) -> Self {
        var copy = self
        copy.attributes.append(customAttributes: .init(name))
        return copy
    }
}
