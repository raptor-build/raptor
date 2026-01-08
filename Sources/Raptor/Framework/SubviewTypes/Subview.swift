//
// Subview.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

/// An opaque value representing the child of another view.
struct Subview: HTML {
    /// The content and behavior of this HTML.
    var body: Never { fatalError() }

    /// The standard set of control attributes for HTML elements.
    var attributes = CoreAttributes()

    /// The underlying HTML content, unattributed.
    private var content: any HTML

    /// The underlying HTML content, with attributes.
    var wrapped: any HTML {
        var wrapped = content
        wrapped.attributes.merge(attributes)
        return wrapped
    }

    /// Creates a new `Subview` instance that wraps the given HTML content.
    /// - Parameter content: The HTML content to wrap
    init(_ wrapped: any HTML) {
        self.content = wrapped
    }

    func render() -> Markup {
        wrapped.render()
    }
}

extension Subview: Equatable {
    nonisolated static func == (lhs: Subview, rhs: Subview) -> Bool {
        lhs.render() == rhs.render()
    }
}

extension Subview {
    /// Returns the stable identity of the wrapped content if it conforms to `Identifiable`.
    var stableID: String? {
        wrapped.stableID
    }
}
