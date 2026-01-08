//
// DefinitionGroup.swift
// Raptor Build
// https://raptor.build
// See LICENSE for license information.
//

/// A container that renders a semantic HTML definition list (`<dl>`).
public struct DefinitionGroup<Content: HTML>: HTML {
    public var body: Never { fatalError() }

    /// Core HTML attributes applied to the definition list.
    public var attributes = CoreAttributes()

    private let content: Content

    /// Creates a definition group using a declarative builder.
    /// - Parameter content: A builder that produces definition entries.
    public init<C>(
        @DefinitionGroupContentBuilder content: () -> C
    ) where Content == DefinitionGroupContentBuilder.Content<C>, C: DefinitionGroupContent {
        self.content = DefinitionGroupContentBuilder.Content(content())
    }

    /// Renders the definition group as a `<dl>` element.
    /// - Returns: The rendered markup.
    public func render() -> Markup {
        Tag("dl") {
            content
        }
        .attributes(attributes)
        .render()
    }
}
