//
// InlineModifiedContentProxy.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

/// A proxy that applies inline modifiers to wrapped content.
public struct ModifiedInlineContentProxy<Modifier: InlineContentModifier>: InlineContent {
    /// The content and behavior of this HTML.
    public var body: Never { fatalError() }

    /// Core HTML attributes for this element.
    public var attributes = CoreAttributes()

    /// The modifier to apply to the content.
    private var modifier: Modifier

    /// The inline content being modified.
    private var content: any InlineContent

    /// Creates a proxy with the specified content and modifier.
    /// - Parameters:
    ///   - content: The inline element to modify.
    ///   - modifier: The modifier to apply.
    init<T: InlineContent>(content: T, modifier: Modifier) {
        self.modifier = modifier
        self.content = content
    }

    /// Renders the modified content as HTML markup.
    /// - Returns: The rendered markup with applied modifications.
    public func render() -> Markup {
        if content.isPrimitive {
            var content = content
            content.attributes.merge(attributes)
            return content.render()
        } else {
            return Markup("<span\(attributes)>\(content.markupString())</span>")
        }
    }
}
