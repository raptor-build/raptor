//
// DocumentBuilder.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

/// A result builder for constructing HTML documents.
///
/// `@DocumentBuilder` combines document components—such as `Head`,
/// `Navigation`, and `Body`—into a complete HTML document.
@resultBuilder
public enum DocumentBuilder {
    /// Creates a document from explicit head and body sections.
    /// - Parameter content: The regions of the document.
    /// - Returns: A `PlainDocument` containing the provided head and body.
    public static func buildBlock<Content: Region>(_ content: Content) -> some Document {
        PlainDocument([content])
    }

    /// Creates a document from explicit head and body sections.
    /// - Parameter regions: The regions of the document.
    /// - Returns: A `PlainDocument` containing the provided head and body.
    public static func buildBlock(_ content: [any Region]) -> some Document {
        PlainDocument(content)
    }

    /// Combines multiple pieces of HTML together.
    /// - Parameters:
    ///   - accumulated: The previous collection of HTML.
    ///   - next: The next piece of HTML to combine.
    /// - Returns: The combined HTML.
    public static func buildBlock<each Content>(
        _ content: repeat each Content
    ) -> some Document where repeat each Content: Region {
        var regions = [any Region]()
        for region in repeat (each content) {
            regions.append(region)
        }
        return PlainDocument(regions)
    }

    /// Passes through an existing `Document` unchanged.
    /// - Parameter component: A fully constructed document.
    /// - Returns: The provided document unchanged.
    public static func buildBlock<Content: Document>(_ component: Content) -> some Document {
        component
    }
}
