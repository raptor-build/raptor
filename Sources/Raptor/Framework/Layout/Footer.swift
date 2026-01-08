//
// Footer.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

/// A container for displaying a page-level announcement.
public struct Footer: Region {
    /// The standard set of control attributes for HTML elements.
    public var attributes = CoreAttributes()

    /// The content of this footer.
    private var content: any HTML

    /// Whether the footer contains meaningful content.
    var isEmpty: Bool {
        content.isEmptyHTML
    }

    /// Creates a footer with the given content.
    /// - Parameter content: The content to display inside the banner.
    public init<Content: HTML>(@HTMLBuilder _ content: () -> Content) {
        self.content = content()
    }

    /// Renders the banner as HTML markup.
    /// - Returns: The rendered banner markup.
    public func render() -> Markup {
        Markup("<footer\(attributes)>\(content.markupString())</footer>")
    }
}
