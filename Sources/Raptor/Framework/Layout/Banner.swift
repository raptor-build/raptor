//
// Banner.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

/// A container for displaying a page-level announcement.
public struct Banner: Region {
    /// The standard set of control attributes for HTML elements.
    public var attributes = CoreAttributes()

    /// The content of this banner.
    private var content: any HTML

    /// The banner's position within the page layout.
    var position: Position? = .fixedTop

    /// Whether the banner contains meaningful content.
    var isEmpty: Bool {
        content.isEmptyHTML
    }

    /// Creates a banner with the given content.
    /// - Parameter content: The content to display inside the banner.
    public init<Content: HTML>(@HTMLBuilder _ content: () -> Content) {
        self.content = content()
    }

    /// Renders the banner as HTML markup.
    /// - Returns: The rendered banner markup.
    public func render() -> Markup {
        content
            .position(position)
            .attributes(attributes)
            .render()
    }
}
