//
// EnvironmentValues.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

import Foundation

/// A type that stores global configuration and Layout settings for your site.
///
/// Environment values are propagated through your site's view hierarchy and can be accessed
/// using the `@Environment` property wrapper. For example:
///
/// ```swift
/// struct ContentView: HTML {
///     @Environment(\.themes) var themes
/// }
/// ```
public struct EnvironmentValues: Sendable {
    /// Provides access to the Markdown posts on this site.
    public var posts: PostCollection

    /// Configuration for RSS/Atom feed generation.
    public var feedConfiguration: FeedConfiguration?

    /// Available themes for the site, including light, dark, and any alternates.
    public var themes: [any Theme]

    /// Locates, loads, and decodes a JSON file in your Resources folder.
    public var decode: DecodeAction

    /// The site's metadata, such as name, description, and URL.
    public let site: SiteMetadata

    /// The author of the site
    public let author: String

    /// The path to the favicon
    public let favicon: URL?

    /// The locales supported by the site.
    public let allLocales: [Locale]

    /// The locale currently being used to render a page.
    internal(set) public var locale: Locale

    /// The localized home path of the site.
    public let homePath: String

    /// The current page being rendered.
    internal(set) public var page: PageMetadata

    init() {
        self.posts = PostCollection(content: [])
        self.feedConfiguration = FeedConfiguration(mode: .full, contentCount: 0)
        self.themes = []
        self.allLocales = []
        self.locale = .automatic
        self.decode = .init(rootDirectory: URL(filePath: ""))
        self.author = ""
        self.favicon = nil
        self.page = .empty
        self.site = .empty
        self.homePath = "/"
    }

    package init(
        rootDirectory: URL,
        site: SiteContext,
        allContent: [Post]
    ) {
        self.decode = DecodeAction(rootDirectory: rootDirectory)
        self.posts = PostCollection(content: allContent)
        self.feedConfiguration = site.feedConfiguration
        self.allLocales = site.locales
        self.themes = site.themes
        self.author = site.author
        self.favicon = site.favicon
        self.page = .empty
        self.locale = .automatic
        self.homePath = locale.homePath(for: site)

        self.site = SiteMetadata(
            name: site.name,
            titleSuffix: site.titleSuffix,
            description: site.description,
            url: site.url)
    }

    package init(
        rootDirectory: URL,
        site: SiteContext,
        locale: Locale,
        allContent: [Post]
    ) {
        self.decode = DecodeAction(rootDirectory: rootDirectory)
        self.posts = PostCollection(content: allContent)
        self.feedConfiguration = site.feedConfiguration
        self.allLocales = site.locales
        self.themes = site.themes
        self.author = site.author
        self.favicon = site.favicon
        self.page = .empty
        self.locale = locale
        self.homePath = locale.homePath(for: site)

        self.site = SiteMetadata(
            name: site.name,
            titleSuffix: site.titleSuffix,
            description: site.description,
            url: site.url)
    }

    init(
        rootDirectory: URL,
        site: SiteContext,
        locale: Locale,
        allContent: [Post],
        pageMetadata: PageMetadata
    ) {
        self.decode = DecodeAction(rootDirectory: rootDirectory)
        self.posts = PostCollection(content: allContent)
        self.feedConfiguration = site.feedConfiguration
        self.themes = site.themes
        self.author = site.author
        self.allLocales = site.locales
        self.favicon = site.favicon
        self.page = pageMetadata
        self.locale = locale
        self.homePath = locale.homePath(for: site)

        self.site = SiteMetadata(
            name: site.name,
            titleSuffix: site.titleSuffix,
            description: site.description,
            url: site.url)
    }
}
