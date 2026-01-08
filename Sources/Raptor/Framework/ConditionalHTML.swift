//
// ConditionalHTML.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

/// A container that conditionally renders one of two HTML content types based on a boolean condition.
public struct ConditionalHTML<TrueContent, FalseContent> {
    /// The core attributes applied to the rendered HTML element.
    public var attributes = CoreAttributes()

    /// The storage mechanism that holds either the true or false content.
    let storage: Storage

    /// Internal storage enum that holds one of the two possible content types.
    enum Storage {
        case trueContent(TrueContent)
        case falseContent(FalseContent)
    }

    /// Creates a conditional HTML container with the specified storage.
    /// - Parameter storage: The storage containing either true or false content.
    init(storage: Storage) {
        self.storage = storage
    }
}

extension ConditionalHTML: HTML where TrueContent: HTML, FalseContent: HTML {
    public var body: Never { fatalError() }

    /// Renders the conditional content as HTML markup.
    /// - Returns: The rendered markup from either the true or false content.
    public func render() -> Markup {
        switch storage {
        case .trueContent(let content):
            content.attributes(attributes).render()
        case .falseContent(let content):
            content.attributes(attributes).render()
        }
    }
}

extension ConditionalHTML: InlineContent, CustomStringConvertible
where TrueContent: InlineContent, FalseContent: InlineContent {
    public var body: Never { fatalError() }

    /// Renders the conditional content as inline HTML markup.
    /// - Returns: The rendered inline markup from either the true or false content.
    public func render() -> Markup {
        switch storage {
        case .trueContent(let content):
            content.attributes(attributes).render()
        case .falseContent(let content):
            content.attributes(attributes).render()
        }
    }
}
