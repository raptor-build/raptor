//
// InlineGroup.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

/// A transparent grouping construct that propagates modifiers to its inline children.
///
/// Use `InlineGroup` when you want to apply shared modifiers to multiple inline elements
/// without introducing additional HTML structure. It passes modifiers through
/// to each child element.
public struct InlineGroup<Content: InlineContent>: InlineContent {
    /// The content and behavior of this HTML.
    public var body: Never { fatalError() }

    /// The standard set of control attributes for HTML elements.
    public var attributes = CoreAttributes()

    private var content: Content

    /// Creates a new group containing the given HTML content.
    /// - Parameter content: A closure that creates the HTML content.
    public init(@InlineContentBuilder content: () -> Content) {
        self.content = content()
    }

    /// Creates a new group containing the given HTML content.
    /// - Parameter content: The HTML content to include.
    public init(_ content: Content) {
        self.content = content
    }

    public func render() -> Markup {
        content.attributes(attributes).render()
    }
}

extension InlineGroup: VariadicInlineContent {
    var subviews: InlineSubviewCollection {
        var content = (content as? any InlineSubviewProvider)?.subviews ??
        InlineSubviewCollection(InlineSubview(content))
        content.attributes.merge(attributes)
        return content
    }
}
