//
// MainContent.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

/// A container that defines the main content area of a page.
///
/// `Main` represents the portion of the page that displays your actual
/// content. Anything you place inside its builder closure becomes part of the
/// page’s primary visible area, which ultimately appears within the document’s
/// `<body>` element.
public struct Main: Region {
    /// A set of vertical edges used to control page-level spacing.
    public struct Edge: OptionSet, Sendable {
        public let rawValue: Int

        /// The top edge of the page.
        public static let top = Edge(rawValue: 1 << 0)

        /// The bottom edge of the page.
        public static let bottom = Edge(rawValue: 1 << 1)

        /// Both the top and bottom edges.
        public static let vertical: Edge = [.top, .bottom]

        public init(rawValue: Int) {
            self.rawValue = rawValue
        }

        /// Generates CSS variables used to apply spacing on the selected edges.
        func spacingStyles(amount: String) -> [Property] {
            var styles: [Property] = []

            if contains(.top) {
                styles.append(.variable("main-spacing-top", value: amount))
            }

            if contains(.bottom) {
                styles.append(.variable("main-spacing-bottom", value: amount))
            }

            return styles
        }
    }

    /// The main content area rendered inside the `<body>` element.
    private var content: (any HTML)?

    /// The standard set of control attributes for HTML elements.
    public var attributes = CoreAttributes()

    /// The background color of the page being rendered.
    var bodyAttributes = CoreAttributes(classes: ["container"])

    /// The metadata section of the document.
    var head = Head()

    /// Creates a `Main` instance using the specified HTML builder.
    /// - Parameter content: The HTML builder closure that produces the main content.
    public init(@HTMLBuilder _ content: () -> some HTML) {
        self.content = content()
    }

    /// Creates a `Main` instance that loads its content from the environment.
    public init() {}

    public func render() -> Markup {
        guard let pageContext = RenderingContext.current else {
            fatalError("Main rendered outside of a rendering context. Please file a bug report.")
        }

        let pageContent = content?.markupString() ?? pageContext.pageMarkup
        return PageContent(pageContent)
            .attributes(attributes)
            .render()
    }
}
