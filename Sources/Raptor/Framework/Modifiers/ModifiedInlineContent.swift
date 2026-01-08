//
// ModifiedInlineElement.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

/// A wrapper that applies inline element modifiers to content.
struct ModifiedInlineContent<Content: InlineContent, Modifier: InlineContentModifier> {
    /// The body of this HTML element, which is itself
    var body: Never { fatalError() }

    /// The standard set of control attributes for HTML elements.
    var attributes = CoreAttributes()

    /// The underlying HTML content, unattributed.
    private var content: Content

    /// The modifier to apply to the content.
    var modifier: Modifier

    /// The unique ID of this element.
    private let id = UUID().uuidString.truncatedHash

    /// The stable ID of the element.
    var stableID: String? {
        content.stableID ?? id
    }

    /// Creates a modified inline element with the specified content and modifier.
    /// - Parameters:
    ///   - content: The inline element to modify.
    ///   - modifier: The modifier to apply.
    init(content: Content, modifier: Modifier) {
        self.content = content
        self.modifier = modifier
    }
}

extension ModifiedInlineContent: InlineContent, VariadicInlineContent {
    /// Applies the modifier to each child in a collection of HTML subviews.
    ///
    /// This method iterates through each child in the provided collection, applies the stored
    /// modifier to it, and combines the modified children into a new collection.
    ///
    /// - Parameter children: A collection of subviews to be modified.
    /// - Returns: A new `SubviewsCollection` containing the modified children.
    private func modify(children: InlineSubviewCollection) -> InlineSubviewCollection {
        var collection = InlineSubviewCollection()
        for child in children {
            let proxy = ModifiedInlineContentProxy(content: child, modifier: modifier)
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
        if let content = content as? any VariadicInlineContent {
            return modify(children: content.subviews).render()
        } else {
            let proxy = ModifiedInlineContentProxy(content: content, modifier: modifier)
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
    /// - Returns: An `InlineSubviewsCollection` containing all modified children.
    var subviews: InlineSubviewCollection {
        let children = (content as? any VariadicInlineContent)?.subviews ??
        InlineSubviewCollection(InlineSubview(content))
        return modify(children: children)
    }
}

extension ModifiedInlineContent: InlineSubviewProvider where Content: InlineSubviewProvider {}

extension ModifiedInlineContent: GridRowProvider where Content: GridRowProvider {
    func gridItems() -> [AnyGridItem] {
        content.gridItems()
    }
}

extension ModifiedInlineContent: GridItemProvider where Content: GridItemProvider {
    var gridItem: AnyGridItem {
        content.gridItem
    }
}

extension ModifiedInlineContent: ColumnProvider where Content: ColumnProvider {}
