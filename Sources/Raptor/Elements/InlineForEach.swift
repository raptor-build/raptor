//
// InlineForEach.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

/// A structure that creates inline content by mapping over a sequence of data.
public struct InlineForEach<Data: Sequence, Content: InlineContent>: InlineContent {
    /// The content and behavior of this HTML.
    public var body: Never { fatalError() }

    /// The standard set of control attributes for HTML elements.
    public var attributes = CoreAttributes()

    /// The sequence of data to iterate over.
    private let data: Data

    /// The child elements contained within this HTML element.
    var subviews: InlineSubviewCollection

    /// Creates a new InlineForEach instance that generates inline content from a sequence.
    /// - Parameters:
    ///   - data: The sequence to iterate over.
    ///   - content: A closure that converts each element into inline content.
    public init(_ data: Data, @InlineContentBuilder content: @escaping (Data.Element) -> Content) {
        self.data = data
        let items = data.map(content)
        self.subviews = InlineSubviewCollection(items)
    }

    /// Renders the ForEach content.
    /// - Returns: The rendered HTML string.
    public func render() -> Markup {
        subviews.attributes(attributes).render()
    }
}

extension InlineForEach: InlineSubviewProvider, VariadicInlineContent {}
