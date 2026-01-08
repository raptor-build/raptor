//
// InlineElementModifier.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

/// A type that modifies inline elements by wrapping or transforming their content.
public protocol InlineContentModifier {
    /// The type of inline element that this modifier produces.
    associatedtype Body: InlineContent

    /// A proxy that provides access to the content being modified.
    typealias Content = ModifiedInlineContentProxy<Self>

    /// Creates the modified inline element.
    /// - Parameter content: The content to be modified.
    /// - Returns: The modified inline element.
    @InlineContentBuilder func body(content: Content) -> Body
}

extension InlineContentModifier {
    /// The rendering context of this modifier.
    var renderingContext: RenderingContext {
        guard let context = RenderingContext.current else {
            fatalError("HTML/renderingContext accessed outside of a rendering context.")
        }
        return context
    }
}
