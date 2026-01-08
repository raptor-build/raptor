//
// PostWidget.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

/// A type that defines custom HTML content that can be injected into posts.
///
/// `PostWidget` represents a reusable piece of declarative HTML that can be
/// embedded directly inside Markdown-based posts using the tokenized type name
/// (for example, `@{Gallery}`).
///
/// Widgets are resolved and rendered during post preprocessing, before
/// Markdown is converted to HTML, allowing rich, structured content to be
/// seamlessly mixed with written text.
public protocol PostWidget {
    /// The type of HTML content this element contains.
    associatedtype Body: HTML

    /// The content and behavior of this `HTML` element.
    @HTMLBuilder var body: Body { get }

    /// Converts this element and its children into HTML markup.
    /// - Returns: A string containing the HTML markup
    func render() -> Markup
}

public extension PostWidget {
    /// Generates the complete `HTML` string representation of the element.
    func render() -> Markup {
        body.class("widget").render()
    }
}
