//
// Embed.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

import Foundation

/// Embeds external content such as YouTube videos, Vimeo videos,
/// Spotify tracks, or arbitrary URLs inside an iframe.
/// - Important: It is recommended to use `aspectRatio()` with `Embed`
/// so that it can scale automatically.
public struct Embed: HTML, LazyLoadable {
    /// A supported external embed source.
    public enum Source: Sendable {
        /// An arbitrary embed URL.
        case url(URL)

        /// A YouTube video embed.
        case youtube(id: String)

        /// A Vimeo video embed.
        case vimeo(id: Int)

        /// A Spotify embed (track, album, playlist, etc.).
        case spotify(id: String, type: SpotifyContentType)

        /// Resolves this embed source into a concrete base URL.
        ///
        /// Provider-specific options (such as Spotify theming)
        /// are applied later during final URL resolution.
        var baseURL: URL? {
            switch self {
            case .url(let url): url
            case .youtube(let id): URL(string: "https://www.youtube-nocookie.com/embed/\(id)")
            case .vimeo(let id): URL(string: "https://player.vimeo.com/video/\(id)")
            case .spotify(let id, let type): URL(string: "https://open.spotify.com/embed/\(type.rawValue)/\(id)")
            }
        }

        /// Returns `true` if this source represents a Spotify embed.
        fileprivate var isSpotify: Bool {
            if case .spotify = self { return true }
            return false
        }
    }

    /// Determines what kind of Spotify embed is being rendered.
    public enum SpotifyContentType: String, Sendable {
        /// An individual Spotify track.
        case track
        /// A Spotify playlist.
        case playlist
        /// A Spotify artist.
        case artist
        /// A Spotify album.
        case album
        /// A Spotify podcast.
        case show
        /// A Spotify podcast episode.
        case episode
    }

    /// Visual theme options supported by Spotify embeds.
    public enum SpotifyEmbedTheme: Int, Sendable {
        /// Light theme.
        case light
        /// Dark theme.
        case dark
    }

    /// The content and behavior of this HTML.
    public var body: Never { fatalError() }

    /// The standard set of control attributes for HTML elements.
    public var attributes = CoreAttributes()

    /// The embed source.
    private let source: Source

    /// A title that describes this embedded content.
    private let title: String

    /// Optional visual theme for Spotify embeds.
    private var spotifyTheme: SpotifyEmbedTheme?

    /// Creates a new `Embed` instance from a raw URL.
    /// - Parameters:
    ///   - title: A title suitable for screen readers.
    ///   - url: The URL to embed on your page.
    public init(title titleKey: String, url: URL) {
        self.title = Localizer.string(titleKey, locale: Self.locale)
        self.source = .url(url)
    }

    /// Creates a new `Embed` instance from a raw URL string.
    /// - Parameters:
    ///   - title: A title suitable for screen readers.
    ///   - url: The URL string to embed on your page.
    public init(title titleKey: String, url: String) {
        self.title = Localizer.string(titleKey, locale: Self.locale)
        self.source = .url(URL(string: url)!)
    }

    /// Creates a new `Embed` instance from a supported embed source.
    /// - Parameters:
    ///   - title: A title suitable for screen readers.
    ///   - source: The embed source.
    public init(title titleKey: String, source: Source) {
        self.title = Localizer.string(titleKey, locale: Self.locale)
        self.source = source
    }

    /// Sets the visual theme for Spotify embeds.
    /// - Parameter theme: The Spotify embed theme to apply.
    /// - Returns: A modified `Embed` instance.
    public func spotifyEmbedTheme(_ theme: SpotifyEmbedTheme) -> Self {
        var copy = self
        copy.spotifyTheme = theme
        return copy
    }

    /// Resolves the final embed URL, applying provider-specific
    /// options such as Spotify theming when applicable.
    /// - Returns: A fully resolved embed URL string, or `nil`
    ///   if the source cannot produce a valid URL.
    private func resolvedURL() -> String? {
        guard let baseURL = source.baseURL else { return nil }

        // Only Spotify supports theming
        guard source.isSpotify, let spotifyTheme else {
            return baseURL.absoluteString
        }

        var components = URLComponents(url: baseURL, resolvingAgainstBaseURL: false)

        components?.queryItems = [
            URLQueryItem(name: "theme", value: String(spotifyTheme.rawValue))
        ]

        return components?.url?.absoluteString
    }

    /// Renders this element into HTML.
    /// - Returns: The HTML for this element.
    public func render() -> Markup {
        // Permissions sufficient for common embedded interactions.
        let allowPermissions = """
        accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share; fullscreen
        """

        guard let url = resolvedURL() else {
            return EmptyHTML().render()
        }

        return Tag("iframe") {}
            .attribute("src", url)
            .attribute("title", title)
            .attribute("allow", allowPermissions)
            .attributes(attributes)
            .render()
    }
}
