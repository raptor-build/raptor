//
// PackHTML.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

/// A container that packs multiple HTML elements together.
///
/// Use `PackHTML` to group HTML elements while maintaining their individual types
/// and applying shared attributes across all contained elements.
struct PackHTML<each Content> {
    /// The standard set of control attributes for HTML elements.
    var attributes = CoreAttributes()

    /// The tuple of elements stored by this type.
    var content: (repeat each Content)

    /// Creates a new pack with the specified HTML content.
    /// - Parameter content: The HTML elements to pack together.
    init(_ content: repeat each Content) {
        self.content = (repeat each content)
    }
}

extension PackHTML: HTML, SubviewProvider, VariadicHTML where repeat each Content: HTML {
    /// The content and behavior of this HTML.
    var body: Never { fatalError() }

    /// Returns the packed elements as a collection of subviews.
    var subviews: SubviewCollection {
        var children = SubviewCollection()
        for element in repeat each content {
            // Using the attributes() modifier will change the type to ModifiedHTML,
            // so to keep the type info, we'll modify the attributes directly
            var child = Subview(element)
            child.attributes.merge(attributes)
            children.elements.append(child)
        }
        return children
    }

    /// Renders all packed elements as combined markup.
    func render() -> Markup {
        subviews.map { $0.render() }.joined()
    }
}

extension PackHTML: InlineContent, InlineSubviewProvider, VariadicInlineContent, CustomStringConvertible
where repeat each Content: InlineContent {
    /// The content and behavior of this HTML.
    var body: Never { fatalError() }

    /// Returns the packed inline elements as a collection.
    var subviews: InlineSubviewCollection {
        var children = InlineSubviewCollection()
        for element in repeat each content {
            var child = InlineSubview(element)
            child.attributes.merge(attributes)
            children.elements.append(child)
        }
        return children
    }

    /// Renders all packed inline elements as combined markup.
    func render() -> Markup {
        subviews.map { $0.render() }.joined()
    }
}

extension PackHTML: TableContent where repeat each Content: TableContent {
    /// Renders all packed table row elements as combined markup.
    func render() -> Markup {
        var markup = Markup()
        for var element in repeat each content {
            element.attributes.merge(attributes)
            markup += element.render()
        }
        return markup
    }
}

extension PackHTML: DefinitionGroupContent where repeat each Content: DefinitionGroupContent {
    /// Renders all packed table row elements as combined markup.
    func render() -> Markup {
        var markup = Markup()
        for var element in repeat each content {
            element.attributes.merge(attributes)
            markup += element.render()
        }
        return markup
    }
}
