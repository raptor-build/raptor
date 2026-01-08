//
// Title.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

/// Provides the title for a given page, which is rendered in the browser and also
/// appears in search engine results.
struct Title: HeadContent {
    /// The standard set of control attributes for HTML elements.
    var attributes = CoreAttributes()

    /// A plain-text string for the page title.
    private var text: String

    /// Creates a new page title using the plain-text string provided.
    /// - Parameter text: The title to use for this page.
    init(_ key: String) {
        let locale: Locale = RenderingContext.current?.locale ?? .automatic
        self.text = Localizer.string(key, locale: locale)
    }

    /// Renders this element into HTML.
    /// - Returns: The HTML for this element.
    func render() -> Markup {
        Markup("<title>\(text)\(renderingContext.site.titleSuffix)</title>")
    }
}
