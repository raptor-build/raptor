//
// Site.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

import Foundation

/// A protocol that defines the configuration and structure of an Raptor website.
///
/// The `Site` protocol is the core configuration point for your Raptor website. It defines
/// everything from basic metadata like the site's name and author, to the layout structure,
/// theming, and content organization.
///
/// To create a site, create a type that conforms to this protocol and implement the required
/// properties. Many properties have default implementations that provide common functionality,
/// which you can override as needed.
///
/// ```swift
/// struct MySite: Site {
///     var name = "My Awesome Site"
///     var url = URL(string: "https://example.com")!
///     var homePage = HomeView()
///     var layout = MainLayout()
///     var darkTheme: (any Theme)? = nil
/// }
/// ```
///
/// - Important: When implementing optional properties like `lightTheme` and `darkTheme`,
///   ensure the return type exactly matches the protocol requirement, e.g., `(any Theme)?`.
///   Swift's type system requires this exact match.
public protocol Site {
    /// The type of your homepage. Required.
    associatedtype HomePageType: Page

    /// The type used to generate your category pages. A default is provided that means
    /// no category pages are generated.
    associatedtype CategoryPageType: CategoryPage

    /// The type of your custom error page. No custom error page is provided by default.
    associatedtype ErrorPageType: ErrorPage

    /// The type of your custom search page. No custom search page is provided by default.
    associatedtype SearchPageType: SearchPage

    /// The type that defines the base layout structure for all pages.
    associatedtype LayoutType: Layout

    /// The post processor to use for each `PostPage`.
    associatedtype PostProcessorType: PostProcessor

    /// A robots.txt configuration for your site. A default is provided that means
    /// all robots can index all pages.
    associatedtype RobotsType: RobotsConfiguration

    /// The color scheme used by the site.
    typealias Scheme = SiteColorScheme

    /// The author of your site, which should be your name.
    /// Defaults to an empty string.
    nonisolated var author: String { get }

    /// A string to append to the end of your page titles. For example, if you have
    /// a page titled "About Me" and a site title suffix of " – My Awesome Site", then
    /// your rendered page title will be "About Me – My Awesome Site".
    /// Defaults to an empty string.
    nonisolated var titleSuffix: String { get }

    /// The name of your site. Required.
    nonisolated var name: String { get }

    /// An optional description for your site. Defaults to nil.
    nonisolated var description: String? { get }

    /// The language your site is published in. Defaults to `.en`.
    nonisolated var locales: [Locale] { get }

    /// The base URL for your site, e.g. https://www.example.com
    nonisolated var url: URL { get }

    /// The post processor to use for content in this site. Note: This
    /// only applies to content pages rendered from the Content folder;
    /// the standard MarkdownToHTML parser is used for `Text` and
    /// other built-in elements regardless of the setting here.
    var postProcessor: PostProcessorType { get }

    /// Controls how the RSS feed for your site should be generated. The default
    /// configuration sends back content description only for 20 items. To disable
    /// your site's RSS feed, set this property to `nil`.
    nonisolated var feedConfiguration: FeedConfiguration? { get }

    /// Controls how search engines and similar index your site. The default
    /// configuration allows all robots to index everything.
    nonisolated var robotsConfiguration: RobotsType { get }

    /// The homepage for your site; what users land on when visiting your root domain.
    var homePage: HomePageType { get }

    /// An array of all the static pages you want to include in your site.
    @PageBuilder var pages: [any Page] { get }

    /// An array of all the post pages you want to include in your site.
    @PostPageBuilder var postPages: [any PostPage] { get }

    /// An array of `HTML` elements to inject into posts.
    @PostWidgetBuilder var postWidgets: [any PostWidget] { get }

    /// A type that conforms to `CategoryPage`, to be used when rendering individual
    /// category pages or the "all categories" page.
    var categoryPage: CategoryPageType { get }

    /// A type that conforms to `ErrorPage`, to be used when rendering status code errors.
    var errorPage: ErrorPageType { get }

    /// A type that conforms to `SearchPage`, to be used when show search results.
    var searchPage: SearchPageType { get }

    /// The base layout applied to all pages. This is used to render all pages that don't
    /// explicitly override the layout with something custom.
    var layout: LayoutType { get }

    /// The color scheme of the site.
    nonisolated var colorScheme: Scheme { get }

    /// The themes used by the website. The site defaults to the first theme in the array.
    @SiteThemeBuilder nonisolated var themes: [any Theme] { get }

    /// Controls how syntax highlighting behaves throughout your site. Languages used
    /// in Markdown files _must_ be included here. Languages specified in `CodeBlock`
    /// will be added automatically.
    nonisolated var syntaxHighlighterConfiguration: SyntaxHighlighterConfiguration { get }

    /// Controls whether HTML output should be formatted with proper indentation.
    ///
    /// - Important: If your site has code blocks containing angle brackets (`<`...`>`),
    /// such as Swift generics, the prettifier will interpret these as HTML tags
    /// and break the code's formatting. To avoid this issue, either set this property
    /// to `false` or replace `<` and `>` with their character entity references,
    /// `&lt;` and `&gt;` respectively.
    nonisolated var prettifyHTML: Bool { get }

    /// The path to the favicon
    nonisolated var favicon: URL? { get }

    /// The set of HTTP error types that this site can handle using its custom error page.
    @ErrorBuilder nonisolated var handledErrors: [any HTTPError] { get }

    /// Override this if you need to do custom work to your site before the build begins,
    /// such as downloading data, creating your staticPages array dynamically, etc.
    mutating func prepare() async throws
}

public extension Site {
    /// No default author.
    nonisolated var author: String { "" }

    /// No default title suffix.
    nonisolated var titleSuffix: String { "" }

    /// No default description.
    nonisolated var description: String? { nil }

    /// English as default locale.
    nonisolated var locales: [Locale] { [.automatic] }

    /// Uses the default color scheme of the system.
    nonisolated var colorScheme: Scheme { .automatic }

    /// Uses the default light theme.
    nonisolated var themes: [any Theme] { [.default] }

    /// Formats HTML output with proper indentation by default.
    nonisolated var prettifyHTML: Bool { true }

    /// No syntax highlighters by default.
    nonisolated var syntaxHighlighterConfiguration: SyntaxHighlighterConfiguration { .automatic }

    /// Use the standard `MarkdownToHTML` processor by default.
    var postProcessor: MarkdownToHTML { .init() }

    /// A default feed configuration allows 20 items of content, showing just
    /// their descriptions.
    nonisolated var feedConfiguration: FeedConfiguration? { .default }

    /// A default robots.txt configuration that allows all robots to index all pages.
    nonisolated var robotsConfiguration: DefaultRobotsConfiguration { DefaultRobotsConfiguration() }

    /// No static pages by default.
    var pages: [any Page] { [] }

    /// No post pages by default.
    var postPages: [any PostPage] { [] }

    /// No post widgets by default.
    var postWidgets: [any PostWidget] { [] }

    /// An empty tag page by default, which triggers no tag pages being generated.
    var categoryPage: EmptyCategoryPage { EmptyCategoryPage() }

    /// An empty error page by default, which triggers no error pages being generated.
    var errorPage: EmptyErrorPage { EmptyErrorPage() }

    /// An empty search page by default, which triggers no search page being generated.
    var searchPage: EmptySearchPage { EmptySearchPage() }

    /// The default favicon being nil
    nonisolated var favicon: URL? { nil }

    /// Defaults to handling only `PageNotFoundError`.
    nonisolated var handledErrors: [any HTTPError] { [PageNotFoundError()] }

    /// Performs the entire publishing flow from a file in user space, e.g. main.swift
    /// or Site.swift.
    /// - Parameters:
    ///   - file: The path of the file that triggered the build. This is used to
    ///   locate the base directory for their project, so we can find
    ///   key folders.
    ///   - buildDirectoryPath: This path will generate the necessary
    ///   artifacts for the web page. Please modify as needed.
    ///   The default is "Build".
    mutating func publish(
        from file: StaticString = #filePath,
        buildDirectoryPath: String = "Build"
    ) async throws {
        let context = try await preparePublishingContext(
            from: file,
            buildDirectoryPath: buildDirectoryPath)

        var publisher = try SitePublisher(
            for: self,
            with: context.content,
            buildContext: context.buildContext,
            rootDirectory: context.rootDirectory,
            buildDirectory: context.buildDirectory)

        try await publisher.publish()
    }

    /// The default implementation does nothing.
    mutating func prepare() async throws {}
}

package extension Site {
    /// Prepares the site for rendering by loading content, resolving environments,
    /// and executing site-level preparation.
    ///
    /// This method performs all shared setup required by both publishing and
    /// development servers, including content loading, environment construction,
    /// localization registration, and build context resolution.
    ///
    /// - Parameters:
    ///   - file: The source file that initiated the build. Used to locate the site root.
    ///   - buildDirectoryPath: The relative path where build artifacts should be written.
    /// - Returns: A fully prepared build state ready for rendering or publishing.
    mutating func preparePublishingContext(
        from file: StaticString = #filePath,
        buildDirectoryPath: String = "Build"
    ) async throws -> PublishingContext {
        let packageDirectory = try URL.packageDirectory(from: file)
        let rootDirectory = packageDirectory
        let buildDirectory = packageDirectory.appending(path: buildDirectoryPath)

        let contentLoader = ContentLoader(
            processor: postProcessor,
            locales: locales,
            widgets: postWidgets)

        var environment = EnvironmentValues(
            rootDirectory: rootDirectory,
            site: self.context,
            allContent: [])

        var renderingContext = RenderingContext(
            site: context,
            posts: [],
            rootDirectory: rootDirectory,
            buildDirectory: buildDirectory,
            environment: environment)

        let (allContent, postContext) = try BuildContext.withNewContext {
            try RenderingContext.$current.withValue(renderingContext) {
                try contentLoader.load(from: rootDirectory)
            }
        }

        environment.posts = PostCollection(content: allContent)
        renderingContext.posts = allContent
        renderingContext.environment = environment

        if isMultilingual {
            Localizer.autoRegister(from: file)
        }

        var (_, buildContext) = try await BuildContext.withNewContext {
            try await RenderingContext.$current.withValue(renderingContext) {
                try await prepare()
            }
        }

        buildContext = buildContext.merging(postContext)
        buildContext.syntaxHighlighterLanguages = OrderedSet(allContent.flatMap(\.syntaxHighlighters))

        return PublishingContext(
            content: allContent,
            buildContext: buildContext,
            rootDirectory: rootDirectory,
            buildDirectory: buildDirectory)
    }

    /// A resolved, immutable snapshot of this site's configuration used during rendering and publishing.
    var context: SiteContext {
        SiteContext(
            name: self.name,
            titleSuffix: self.titleSuffix,
            description: self.description,
            url: self.url,
            feedConfiguration: self.feedConfiguration,
            locales: self.locales,
            themes: self.themes,
            author: self.author,
            favicon: self.favicon,
            isSearchEnabled: self.isSearchEnabled,
            isMultilingual: self.isMultilingual,
            syntaxHighlighterConfiguration: self.syntaxHighlighterConfiguration,
            colorScheme: self.colorScheme,
            highlighterThemes: Array(self.allSyntaxHighlighterThemes),
            robotsConfiguration: self.robotsConfiguration,
            prettifyHTML: self.prettifyHTML,
            postProcessor: self.postProcessor
        )
    }

    /// Whether the site has enabled search.
    var isSearchEnabled: Bool {
        !(searchPage is EmptySearchPage)
    }

    /// Whether the site supports multiple languages.
    var isMultilingual: Bool {
        locales.count > 1
    }

    /// Returns the site's global layout when `DefaultLayout` is requested,
    /// otherwise returns the provided layout unchanged.
    /// - Parameter page: The page that uses the layout.
    /// - Returns: The resolved layout for the page.
    func layout(for page: some PageRepresentable) -> any Layout {
        page.usesDefaultLayout ? layout : page.layout
    }

    /// Locates the best layout to use for a piece of Markdown content. Layouts
    /// are specified using YAML front matter, but if none are found then the first
    /// layout in your site's `layouts` property is used.
    /// - Parameter content: The content that is being rendered.
    /// - Returns: The correct `PostPage` instance to use for this post.
    func postPage(for post: Post) -> any PostPage {
        if let name = post.layout {
            if let match = postPages.first(where: {
                String(describing: type(of: $0)) == name
            }) {
                return match
            }
            fatalError(BuildError.missingNamedLayout(name).description)
        }
        return postPages.first ?? {
            fatalError(BuildError.missingDefaultLayout.description)
        }()
    }
}

extension Site {
    /// Whether the site uses more than one theme.
    var hasMultipleThemes: Bool {
        themes.count > 1
    }

    /// The default locale of the site.
    var defaultLocale: Locale? {
        locales.first
    }

    /// The syntax highlighting themes from every site theme.
    var allSyntaxHighlighterThemes: [any SyntaxHighlighterTheme] {
        let all = themes.flatMap {
            ResolvedTheme($0).syntaxHighlighterThemes
        }

        let deduped = all.reduce(into: [String: any SyntaxHighlighterTheme]()) {
            $0[$1.id] = $1
        }

        return deduped.values.sorted { $0.id < $1.id }
    }
}
