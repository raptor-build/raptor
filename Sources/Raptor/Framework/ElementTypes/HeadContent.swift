//
// HeadElement.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

/// A metadata element that can exist in the `Head` struct.
/// - Warning: Do not conform to this type directly.
protocol HeadContent {
    /// The standard set of control attributes for HTML elements.
    var attributes: CoreAttributes { get set }

    /// Renders the head element as markup.
    /// - Returns: The rendered markup representation.
    func render() -> Markup
}

extension HeadContent {
    /// The rendering context of this element.
    var renderingContext: RenderingContext {
        guard let context = RenderingContext.current else {
            fatalError("HeadContent/renderingContext accessed outside of a rendering context.")
        }
        return context
    }

    /// Converts this element and its children into an HTML string with attributes.
    /// - Returns: A string containing the HTML markup
    func markupString() -> String {
        render().string
    }
}
