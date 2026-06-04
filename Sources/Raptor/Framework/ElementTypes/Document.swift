//
// Document.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

/// A protocol that defines an HTML document.
/// - Warning: Do not conform to this protocol directly.
public protocol Document {
    
    //Adding a withRTL parameter will
    //let us know if we are rendering for an RTL language
    
    /// Renders the document as markup.
    /// - Returns: The rendered markup representation.
    func render(withRTL : Bool) -> Markup
}

extension Document {
    /// Converts this element and its children into an HTML string with attributes.
    /// - Returns: A string containing the HTML markup
    ///
    func markupString(withRTL : Bool = false) -> String {
        //Addition of withRTL parameters lets the rendered know if
        //it's rendering for an RTL language or not ?
        //This is not a breaking change cause it's defaults to false
        render(withRTL: withRTL).string
    }

    /// The rendering context of this document.
    var renderingContext: RenderingContext {
        guard let context = RenderingContext.current else {
            fatalError("Document/renderingContext accessed outside of a rendering context.")
        }
        return context
    }
}
