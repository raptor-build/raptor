//
// DefinitionGroupBuilder.swift
// Raptor Build
// https://raptor.build
// See LICENSE for license information.
//

/// A result builder that constructs the contents of a definition group.
@resultBuilder
public enum DefinitionGroupContentBuilder {
    /// Wraps a single definition group element.
    /// - Parameter content: A definition group element.
    /// - Returns: The same element.
    public static func buildExpression<C: DefinitionGroupContent>(_ content: C) -> C {
        content
    }

    /// Builds a single definition group element.
    /// - Parameter content: A definition group element.
    /// - Returns: The same element.
    public static func buildBlock<C: DefinitionGroupContent>(_ content: C) -> C {
        content
    }

    /// Combines multiple definition group elements into a single group.
    /// - Parameter content: A variadic list of definition group elements.
    /// - Returns: A combined definition group content.
    public static func buildBlock<each C: DefinitionGroupContent>(
        _ content: repeat each C
    ) -> some DefinitionGroupContent {
        PackHTML(repeat each content)
    }
}

public extension DefinitionGroupContentBuilder {
    /// A type-erased wrapper for builder-produced definition group content.
    struct Content<C>: HTML where C: DefinitionGroupContent {

        public var body: Never { fatalError() }

        /// Core HTML attributes applied to the wrapped content.
        public var attributes = CoreAttributes()

        private var content: C

        /// Creates a wrapper for definition group content.
        /// - Parameter content: The definition group content to wrap.
        init(_ content: C) {
            self.content = content
        }

        /// Renders the wrapped content as HTML markup.
        /// - Returns: The rendered markup.
        public func render() -> Markup {
            content.render()
        }
    }
}
