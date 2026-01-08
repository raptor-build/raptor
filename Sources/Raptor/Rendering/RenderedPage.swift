//
// RenderedPage.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

import SwiftSoup

/// Represents the result of rendering a single page in Raptor.
///
/// `RenderedPage` contains all information needed to:
/// - Write the page to disk during static publishing, **or**
/// - Return the page via server-side frameworks (e.g., Vapor)
///
/// Each rendered page includes:
/// - The final HTML string
/// - The path where the page would normally be written
/// - An optional sitemap priority
/// - The filename to use (defaults to `"index"` in most cases)
///
/// This type allows Raptor's rendering pipeline to be reused in both
/// static builds and dynamic server rendering without duplicating logic.
package struct RenderedPage: Sendable {
    /// The fully rendered HTML output for this page.
    package let html: String

    /// The site-relative directory path where this page belongs.
    ///
    /// Examples:
    /// - `"/about"`
    /// - `"blog/my-post"`
    /// - `"/"` for the homepage
    ///
    /// During static publishing, this becomes:
    /// `Build/<locale>/<path>/<filename>.html`
    package let path: URL

    /// An optional sitemap priority in the range `0.0`–`1.0`.
    ///
    /// If `nil`, the page is excluded from the sitemap.
    package let priority: Double?

    /// The filename to use when writing this page.
    ///
    /// Defaults to `"index"` for most pages, producing:
    /// `"index.html"`
    package let filename: String

    /// The metadata of used in site-wide search.
    package var searchMetadata: SearchMetadata?

    /// Creates a new `RenderedPage` instance.
    /// - Parameters:
    ///   - html: The full HTML markup for the page.
    ///   - prettify: Whether the HTML should be pretty printed.
    ///   - path: The site-relative path where the page belongs.
    ///   - priority: An optional sitemap priority (0.0–1.0). Defaults to `nil`.
    ///   - filename: The output filename (without extension). Defaults to `"index"`.
    package init(
        html: String,
        prettify: Bool = false,
        path: URL,
        priority: Double? = nil,
        filename: String = "index",
        searchMetadata: SearchMetadata? = nil
    ) {
        self.html = prettify ? Self.prettifyHTML(html) : html
        self.path = path
        self.priority = priority
        self.filename = filename
        self.searchMetadata = searchMetadata
    }

    /// Formats HTML content with proper indentation and line breaks, returning original HTML if formatting fails.
    private static func prettifyHTML(_ html: String) -> String {
        do {
            let doc = try SwiftSoup.parse(html)
            doc.outputSettings()
                .prettyPrint(pretty: true)
                .indentAmount(indentAmount: 2)
            return try doc.outerHtml()
        } catch {
            BuildContext.logWarning("HTML could not be prettified: \(error.localizedDescription).")
            return html
        }
    }
}
