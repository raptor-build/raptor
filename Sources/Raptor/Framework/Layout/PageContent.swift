//
// PageContent.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

/// An opaque container for the content of a page,
/// which is constructed dynamically during the publishing
/// process at runtime.
struct PageContent: HTML {
    /// The content and behavior of this HTML.
    var body: Never { fatalError() }

    /// The standard set of control attributes for HTML elements.
    var attributes = CoreAttributes()

    /// The content of page being rendered.
    private var content: any HTML

    init(_ content: any HTML) {
        self.content = content
    }

    init(_ content: String) {
        self.content = InlineHTML(content)
    }

    func render() -> Markup {
        Markup("<main\(attributes)>\(content.markupString())</main>")
    }
}
