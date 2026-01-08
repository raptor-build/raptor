//
// Definition.swift
// Raptor Build
// https://raptor.build
// See LICENSE for license information.
//

/// A single definition entry consisting of a term (`<dt>`) and description (`<dd>`).
public struct Definition<Term: InlineContent, Content: HTML>: DefinitionGroupContent {
    /// The body of this HTML element.
    public var body: Never { fatalError() }

    /// Core HTML attributes applied to the term-description pair.
    public var attributes = CoreAttributes()

    /// The definition term rendered as a `<dt>` element.
    private let term: Term

    /// The definition description rendered as a `<dd>` element.
    private let description: Content

    /// Creates a definition with a string label and HTML description.
    /// - Parameters:
    ///   - term: The definition term text.
    ///   - description: A builder that produces the description content.
    public init(
        _ term: String,
        @HTMLBuilder description: () -> Content
    ) where Term == String {
        self.term = term
        self.description = description()
    }

    /// Creates a definition with fully custom label and description content.
    /// - Parameters:
    ///   - description: A builder that produces the description content.
    ///   - term: A builder that produces the label content.
    public init(
        @HTMLBuilder description: () -> Content,
        @InlineContentBuilder term: () -> Term
    ) {
        self.term = term()
        self.description = description()
    }

    /// Renders the definition as a `<dt>` followed by a `<dd>`.
    /// - Returns: The rendered markup.
    public func render() -> Markup {
        let termAttributes = term.attributes
        let descriptionAttributes = description.attributes

        var term = term
        term.attributes = .init()

        var description = description
        description.attributes = .init()

        return Section {
            Tag("dt") {
                term
            }
            .attributes(termAttributes)

            Tag("dd") {
                description
            }
            .attributes(descriptionAttributes)
        }
        .attributes(attributes)
        .render()
    }
}
