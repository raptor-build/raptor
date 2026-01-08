//
// Document.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

/// A protocol that defines an HTML document.
/// - Warning: Do not conform to this protocol directly.
public protocol Document {
    /// Renders the document as markup.
    /// - Returns: The rendered markup representation.
    func render() -> Markup
}

extension Document {
    /// Converts this element and its children into an HTML string with attributes.
    /// - Returns: A string containing the HTML markup
    func markupString() -> String {
        render().string
    }

    /// The rendering context of this document.
    var renderingContext: RenderingContext {
        guard let context = RenderingContext.current else {
            fatalError("Document/renderingContext accessed outside of a rendering context.")
        }
        return context
    }
}
