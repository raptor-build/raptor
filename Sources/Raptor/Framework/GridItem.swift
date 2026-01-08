//
// GridItem.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

/// A typed grid item that wraps HTML or inline content for placement in a grid.
struct GridItem<Content>: GridItemProvider {
    /// The content and behavior of this HTML.
    var body: Never { fatalError() }

    /// The standard set of control attributes for this grid item.
    var attributes = CoreAttributes()

    /// The type-erased grid content backing this item.
    var gridItem: AnyGridItem

    /// Creates a grid item from block-level HTML content.
    /// - Parameters:
    ///   - content: The HTML content to place in the grid.
    ///   - columnSpan: The number of grid columns the item should span.
    init<Item: HTML>(content: Item, columnSpan: Int) {
        self.gridItem = AnyGridItem(content, columnSpan: columnSpan)
    }

    /// Creates a grid item from inline content.
    /// - Parameters:
    ///   - content: The inline content to place in the grid.
    ///   - columnSpan: The number of grid columns the item should span.
    init<Item: InlineContent>(content: Item, columnSpan: Int) {
        self.gridItem = AnyGridItem(InlineHTML(content), columnSpan: columnSpan)
    }

    /// Renders the grid item as HTML markup.
    /// - Returns: The rendered HTML markup for this grid item.
    func render() -> Markup {
        gridItem.attributes(attributes).render()
    }
}

extension GridItem: HTML where Content: HTML {}
extension GridItem: InlineContent, CustomStringConvertible where Content: InlineContent {}
