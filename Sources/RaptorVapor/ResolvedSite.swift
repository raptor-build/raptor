//
// ResolvedSite.swift
// RaptorVapor
// https://raptor.build
// See LICENSE for license information.
//

/// The fully prepared site returned by `.serve()`, stored inside
/// `Application.storage` so Vapor routes can dynamically render pages.
///
/// A `ServedSite` bundles the resolved `Site`, all parsed posts,
/// and the project's source directory.
struct ResolvedSite: Sendable {
    /// The storage key used to install this site into `Application.storage`.
    struct Key: StorageKey {
        // swiftlint:disable:next nesting
        typealias Value = ResolvedSite
    }

    /// The resolved user `Site` instance after `.serve()`.
    nonisolated(unsafe) private let site: any Site

    /// All parsed Markdown posts available for rendering.
    let posts: [Post]

    /// The root directory of the project on disk.
    let rootDirectory: URL

    /// The build context generated during publishing.
    let buildContext: BuildContext

    /// Creates a new served site with resolved configuration and content.
    init(
        site: any Site,
        posts: [Post],
        rootDirectory: URL,
        buildContext: BuildContext
    ) {
        self.site = site
        self.posts = posts
        self.rootDirectory = rootDirectory
        self.buildContext = buildContext
    }

    /// A placeholder value used before the site is initialized.
    static var empty: ResolvedSite {
        .init(site: EmptySite(), posts: [], rootDirectory: URL(filePath: "/dev/null"), buildContext: .init())
    }

    /// The resolved context for the underlying site.
    var context: SiteContext { site.context }

    /// The site's homepage instance.
    var homePage: any Page { site.homePage }

    /// All static pages declared on the site.
    var pages: [any Page] { site.pages }

    /// The category listing page used by the site.
    var categoryPage: any CategoryPage { site.categoryPage }

    /// The search page configuration.
    var searchPage: any SearchPage { site.searchPage }

    /// The site's error page.
    var errorPage: any ErrorPage { site.errorPage }

    /// Indicates whether search is enabled for the site.
    var isSearchEnabled: Bool { site.isSearchEnabled }

    /// All locales supported by the site.
    var locales: [Locale] { site.locales }

    /// Resolves the correct layout to use for the given page.
    /// - Parameter page: The page whose layout is being requested.
    /// - Returns: The resolved layout for that page.
    func layout(for page: some PageRepresentable) -> any Layout {
        site.layout(for: page)
    }

    /// Returns the page template used to render a given post.
    /// - Parameter post: The post being rendered.
    /// - Returns: The resolved post page instance.
    func postPage(for post: Post) -> any PostPage {
        site.postPage(for: post)
    }
}

/// A placeholder static page used only by `EmptySite`.
private struct EmptyStaticPage: Page {
    var title: String = "Empty"
    var body: some HTML { EmptyHTML() }
}

/// A placeholder site used only for `ServedSite.empty`.
private struct EmptySite: Site {
    var name: String = "Empty"
    var layout = EmptyLayout()
    var url: URL = URL(string: "https://example.com")!
    var homePage = EmptyStaticPage()
}
