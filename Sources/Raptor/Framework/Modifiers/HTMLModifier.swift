//
// HTMLModifier.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

/// A type that modifies HTML content.
public protocol HTMLModifier {
    /// The type of HTML content this modifier produces.
    associatedtype Body: HTML

    /// A proxy that provides access to the content being modified.
    typealias Content = ModifiedContentProxy<Self>

    /// Returns the modified HTML content.
    /// - Parameter content: The content to modify.
    /// - Returns: The modified HTML content.
    @HTMLBuilder func body(content: Content) -> Body
}

extension HTMLModifier {
    /// The rendering context of this modifier.
    var renderingContext: RenderingContext {
        guard let context = RenderingContext.current else {
            fatalError("HTML/renderingContext accessed outside of a rendering context.")
        }
        return context
    }
}
