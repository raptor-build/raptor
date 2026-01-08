//
// ModifiedHTML.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

/// A container that applies a modifier to HTML content.
///
/// Use `ModifiedHTML` to wrap content with styling, attributes, or behavior modifications
/// while preserving the original content structure.
struct ModifiedHTML<Content, Modifier> {
    /// The body of this HTML element, which is itself
    var body: Never { fatalError() }

    /// The standard set of control attributes for HTML elements.
    var attributes = CoreAttributes()

    /// The underlying HTML content, unattributed.
    private var content: Content

    /// The modifier applied to the content.
    var modifier: Modifier

    /// The unique ID of this element.
    private let id = UUID().uuidString.truncatedHash

    /// Creates a modified HTML container.
    /// - Parameters:
    ///   - content: The HTML content to modify.
    ///   - modifier: The modifier to apply to the content.
    init(content: Content, modifier: Modifier) {
        self.content = content
        self.modifier = modifier
    }
}

extension ModifiedHTML: HTML, VariadicHTML where Content: HTML, Modifier: HTMLModifier {
    /// The stable ID of the element.
    var stableID: String? {
        content.stableID ?? id
    }

    /// Applies the modifier to each child in a collection of HTML subviews.
    ///
    /// This method iterates through each child in the provided collection, applies the stored
    /// modifier to it, and combines the modified children into a new collection.
    ///
    /// - Parameter children: A collection of subviews to be modified.
    /// - Returns: A new `SubviewsCollection` containing the modified children.
    private func modify(children: SubviewCollection) -> SubviewCollection {
        var collection = SubviewCollection()
        for child in children {
            let proxy = ModifiedContentProxy(content: child, modifier: modifier)
            var modified = modifier.body(content: proxy)
            modified.attributes.merge(attributes)
            collection.elements.append(.init(modified))
        }
        return collection
    }

    /// Generates the HTML markup for this modified content.
    ///
    /// This method determines whether the content is variadic (contains multiple children)
    /// or singular, then applies the appropriate modification strategy to generate the final markup.
    ///
    /// - Returns: A `Markup` object representing the HTML structure after modifications have been applied.
    func render() -> Markup {
        if let content = content as? any VariadicHTML {
            return modify(children: content.subviews).render()
        } else {
            let proxy = ModifiedContentProxy(content: content, modifier: modifier)
            var modified = modifier.body(content: proxy)
            modified.attributes.merge(attributes)
            return modified.render()
        }
    }

    /// The collection of child elements after modifications have been applied.
    ///
    /// This computed property first obtains the children from the underlying content,
    /// then applies the stored modifier to each child. If the content isn't variadic,
    /// it's treated as a single child.
    ///
    /// - Returns: A `SubviewsCollection` containing all modified children.
    var subviews: SubviewCollection {
        let children = (content as? any VariadicHTML)?.subviews ?? SubviewCollection(Subview(content))
        return modify(children: children)
    }
}

extension ModifiedHTML: SubviewProvider where Content: HTML & SubviewProvider, Modifier: HTMLModifier {}

extension ModifiedHTML: ColumnProvider where Content: ColumnProvider {}

extension ModifiedHTML: GridRowProvider where Content: GridRowProvider {
    func gridItems() -> [AnyGridItem] {
        content.gridItems()
    }
}

extension ModifiedHTML: GridItemProvider where Content: GridItemProvider {
    var gridItem: AnyGridItem {
        content.gridItem
    }
}
