//
// ForEach.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

/// A structure that creates HTML content by mapping over a sequence of data.
public struct ForEach<Data, Content: HTML> {
    /// The content and behavior of this HTML.
    public var body: Never { fatalError() }

    /// The standard set of control attributes for HTML elements.
    public var attributes = CoreAttributes()

    /// The sequence of data to iterate over.
    private let data: Data

    /// The child elements contained within this HTML element.
    var subviews: SubviewCollection

    /// The content with any transformations required by the data type.
    private var content: any HTML

    /// Creates a ForEach instance for search results.
    /// - Parameters:
    ///   - data: The search result collection to iterate over.
    ///   - content: A closure that converts each search result into HTML content.
    public init(
        _ data: SearchResultCollection,
        @HTMLBuilder content: (SearchResult) -> Content
    ) where Data == SearchResultCollection {
        self.data = data
        let items = data.map(content)
        let subviews = SubviewCollection(items)

        let content = Section {
            Tag("template") {
                Section(subviews)
                    .class("search-result-item")
            }
            .id("search-result-template")
        }
        .id("search-results")

        self.subviews = subviews
        self.content = content
    }

    /// Renders the ForEach content when this isn't part of a list.
    /// - Returns: The rendered HTML string.
    public func render() -> Markup {
        content.attributes(attributes).render()
    }
}

extension ForEach: SubviewProvider, VariadicHTML where Data: Sequence {
    /// Creates a new ForEach instance that generates HTML content from a sequence.
    /// - Parameters:
    ///   - data: The sequence to iterate over.
    ///   - content: A closure that converts each element into HTML content.
    public init(
        _ data: Data,
        @HTMLBuilder content: (Data.Element) -> Content
    ) {
        self.data = data
        let items = data.map(content)
        self.subviews = SubviewCollection(items)
        self.content = subviews
    }
}

extension ForEach: HTML {}

extension ForEach: ColumnProvider where Content: ColumnProvider {}
