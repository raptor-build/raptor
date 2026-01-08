//
// InlineSubview.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

/// An opaque value representing the child of another view.
struct InlineSubview: InlineContent {
    /// The content and behavior of this HTML.
    var body: Never { fatalError() }

    /// The standard set of control attributes for HTML elements.
    var attributes = CoreAttributes()

    /// The underlying HTML content, unattributed.
    private var content: any InlineContent

    /// The underlying HTML content, with attributes.
    var wrapped: any InlineContent {
        var wrapped = content
        wrapped.attributes.merge(attributes)
        return wrapped
    }

    /// Creates a new `Child` instance that wraps the given HTML content.
    /// - Parameter content: The HTML content to wrap
    init(_ wrapped: any InlineContent) {
        self.content = wrapped
    }

    nonisolated func render() -> Markup {
        wrapped.render()
    }
}

extension InlineSubview: Equatable {
    nonisolated static func == (lhs: InlineSubview, rhs: InlineSubview) -> Bool {
        lhs.render() == rhs.render()
    }
}
