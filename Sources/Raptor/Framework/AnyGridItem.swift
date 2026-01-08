//
// AnyGridItem.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

/// A type-erased container that wraps HTML content for use inside a grid layout.
struct AnyGridItem: HTML {
    /// The content and behavior of this HTML.
    var body: Never { fatalError() }

    /// The standard set of control attributes for this grid item.
    var attributes: CoreAttributes = .init()

    /// The wrapped HTML content.
    private var content: any HTML

    /// The number of grid columns this item spans.
    var columnSpan = 1

    /// Creates a grid content wrapper from HTML, preserving existing grid metadata when available.
    /// - Parameters:
    ///   - content: The HTML content to wrap.
    ///   - columnSpan: The number of grid columns the content should span.
    init(_ content: any HTML, columnSpan: Int = 1) {
        if let provider = content as? any GridItemProvider {
            self = provider.gridItem
        } else {
            self.content = content
            self.columnSpan = columnSpan
        }
    }

    /// Renders the wrapped content as HTML markup, applying grid span styling when needed.
    /// - Returns: The rendered HTML markup for this grid item.
    func render() -> Markup {
        var attributes = attributes
        if columnSpan > 1 {
            attributes.append(styles: .gridColumn(.span(columnSpan)))
        }
        return content.attributes(attributes).render()
    }
}
