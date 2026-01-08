//
// SiteContext.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

/// Defines all static configuration for a site as declared by the user.
package struct SiteContext: Sendable {
    /// The display name of the site.
    let name: String

    /// A suffix automatically appended to page titles.
    let titleSuffix: String

    /// A short descriptive summary of the site.
    let description: String?

    /// The root URL where the site will be hosted.
    let url: URL

    /// Configuration for generating RSS/Atom feeds.
    let feedConfiguration: FeedConfiguration?

    /// All locales supported by the site.
    package let locales: [Locale]

    /// All visual themes available to the site.
    let themes: [any Theme]

    /// The default author used for generated pages and posts.
    let author: String

    /// The URL of the favicon used for the site.
    let favicon: URL?

    /// Indicates whether built-in search support is enabled.
    let isSearchEnabled: Bool

    /// Indicates whether the site supports multiple languages.
    let isMultilingual: Bool

    /// Global configuration for syntax highlighting behavior.
    let syntaxHighlighterConfiguration: SyntaxHighlighterConfiguration

    /// The preferred global color scheme for the site.
    let colorScheme: SiteColorScheme

    /// Themes used for syntax highlighting across the site.
    let highlighterThemes: [any SyntaxHighlighterTheme]

    /// Configuration for generating the site's robots.txt file.
    let robotsConfiguration: RobotsConfiguration

    /// Whether HTML output should be formatted with proper indentation.
    let prettifyHTML: Bool

    /// The first locale in the site's locale list, used as the default.
    var defaultLocale: Locale? {
        locales.first
    }

    /// The post processor used to parse Markdown.
    let postProcessor: any PostProcessor
}
