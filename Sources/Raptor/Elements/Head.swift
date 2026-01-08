//
// HTMLHead.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

import Foundation
import OrderedCollections

/// A representation of the content inside the HTML `<head>` element.
struct Head {
    /// A semantic key representing a single logical metadata element.
    enum MetadataKey: Hashable {
        // Standard metadata
        case characterEncoding
        case viewport
        case canonicalURL
        case generator
        case robots

        // Open Graph metadata
        case openGraphTitle
        case openGraphDescription
        case openGraphImage
        case openGraphURL
        case openGraphSiteName

        // Twitter metadata
        case twitterTitle
        case twitterDescription
        case twitterImage
        case twitterDomain
        case twitterDoNotTrack
        case twitterCardStyle

        // HTTP-equivalent metadata
        case contentSecurityPolicy
    }

    /// A dictionary of metadata elements keyed by semantic identity.
    var elements: OrderedDictionary<MetadataKey, any HeadContent> = [:]

    /// A list of additional head elements that preserve explicit insertion order.
    var extras: [any HeadContent] = []

    /// Indicates whether standard metadata and system assets should be included.
    var includesStandardHeaders = true

    /// Specifies the default target used by all links in this document.
    var defaultLinkTarget: LinkOpenBehavior?

    /// The rendering context of this element.
    private var renderingContext: RenderingContext {
        guard let context = RenderingContext.current else {
            fatalError("Head/renderingContext accessed outside of a rendering context.")
        }
        return context
    }

    /// Page-level metadata derived from the current rendering environment.
    private var pageMetadata: PageMetadata {
        renderingContext.environment.page
    }

    /// Site-wide configuration and identity metadata.
    private var siteContext: SiteContext {
        renderingContext.site
    }

    /// Build-time configuration affecting emitted assets and behavior.
    private var buildContext: BuildContext {
        BuildContext.current
    }

    /// Font resources registered with the build context that should be preloaded.
    private var fontPreloads: [any HeadContent] {
        let fonts = OrderedSet(siteContext.themes.flatMap(\.resolved.fonts))

        return fonts.compactMap { font -> (any HeadContent)? in
            guard let source = font.sources.first(where: {
                $0.url.pathExtension == "woff2"
                && $0.weight == .regular
                && $0.variant == .normal
            }) else {
                return nil
            }

            return Resource(href: source.url, rel: .preload)
                .attribute("as", "font")
                .attribute("type", "font/woff2")
                .attribute("crossorigin")
        }
    }

    /// All required client-side scripts for the current page.
    @HeadContentBuilder private var scripts: [any HeadContent] {
        if BuildContext.current.syntaxHighlighterLanguages.isEmpty == false {
            Script(file: "/js/prism.js").defer()
        }

        Script(file: "/js/raptor-core.js").defer()

        if RenderingContext.current?.site.isSearchEnabled == true {
            Script(file: "/js/raptor-search.js").defer()
            Script(file: "/js/lunr.js").defer()
        }
    }

    /// Metadata required for a minimally complete and identifiable document.
    @HeadContentBuilder private var requiredDocumentMetadata: [any HeadContent] {
        Title(pageMetadata.title)

        if !pageMetadata.description.isEmpty {
            Metadata(name: "description", content: pageMetadata.description)
        }

        if !siteContext.author.isEmpty {
            Metadata(name: "author", content: siteContext.author)
        }

        if let faviconURL = siteContext.favicon {
            Resource(href: faviconURL, rel: .icon)
        }

        Resource.iconCSS
    }

    /// Overridable document metadata that establishes identity and canonical context.
    private var overridableDocumentMetadata: OrderedDictionary<MetadataKey, any HeadContent> {
        var output: OrderedDictionary<MetadataKey, any HeadContent> = [:]

        output[.characterEncoding] = Metadata.utf8
        output[.viewport] = Metadata.flexibleViewport
        output[.canonicalURL] = Resource(href: pageMetadata.url, rel: "canonical")

        return output
    }

    /// Social metadata used by Open Graph and Twitter for link previews.
    private var socialMetadata: OrderedDictionary<MetadataKey, any HeadContent> {
        var output: OrderedDictionary<MetadataKey, any HeadContent> = [:]

        output[.openGraphSiteName] = Metadata(.openGraphSiteName, content: siteContext.name)

        if let imageURL = pageMetadata.image {
            output[.openGraphImage] = Metadata(.openGraphImage, content: imageURL)
            output[.twitterImage] = Metadata(.twitterImage, content: imageURL)
        }

        output[.openGraphTitle] = Metadata(.openGraphTitle, content: pageMetadata.title)
        output[.twitterTitle] = Metadata(.twitterTitle, content: pageMetadata.title)

        if !pageMetadata.description.isEmpty {
            let description = pageMetadata.description
            output[.openGraphDescription] = Metadata(.openGraphDescription, content: description)
            output[.twitterDescription] = Metadata(.twitterDescription, content: description)
        }

        output[.openGraphURL] = Metadata(.openGraphURL, content: pageMetadata.url)

        if let domain = pageMetadata.url.removingWWW {
            output[.twitterDomain] = Metadata(.twitterDomain, content: domain)
        }

        output[.twitterDoNotTrack] = Metadata(.twitterDoNotTrack, content: "on")
        output[.twitterCardStyle] = Metadata(.twitterCard, content: "summary_large_image")

        return output
    }

    /// System stylesheet, script, and highlighter resources required by Raptor.
    private var systemAssets: [any HeadContent] {
        var assets: [any HeadContent] = []

        if siteContext.colorScheme == .automatic, let script = colorSchemingScript {
            assets.append(script)
        }

        if buildContext.navigationReservesSpace {
            assets.append(reservedNavigationSpaceScript)
        }

        assets.append(Resource.raptorCoreCSS)

        if buildContext.includesSegmentedControl {
            assets.append(Script(file: "/js/raptor-segmented-controls.js"))
        }

        if buildContext.navigationReservesSpace {
            assets.append(Script(file: "/js/raptor-nav-reserved-space.js"))
        }

        if !buildContext.syntaxHighlighterLanguages.isEmpty {
            var highlighterThemes = [any SyntaxHighlighterTheme]()
            highlighterThemes += siteContext.highlighterThemes
            highlighterThemes += buildContext.syntaxHighlighterThemes
            assets.append(Resource.prismCSS)
            assets.append(Resource.prismThemesCSS)
        }

        return assets
    }

    /// Renders the full `<head>` element for the current document.
    /// - Returns: A `Markup` value containing the final `<head>` contents.
    func render() -> Markup {
        var resolvedMetadata = overridableDocumentMetadata

        if includesStandardHeaders {
            resolvedMetadata[.generator] = Metadata.generator
            resolvedMetadata.merge(socialMetadata) { _, new in new }
        }

        resolvedMetadata.merge(elements) { _, new in new }

        var allHeadElements = [any HeadContent]()
        allHeadElements.append(contentsOf: resolvedMetadata.values)
        allHeadElements.append(contentsOf: requiredDocumentMetadata)

        if includesStandardHeaders {
            allHeadElements.append(contentsOf: fontPreloads)
            allHeadElements.append(contentsOf: systemAssets)
        }

        allHeadElements.append(contentsOf: scripts)
        allHeadElements.append(contentsOf: extras)

        var output: [String] = []

        if let targetName = defaultLinkTarget?.name {
            output.append("<base target=\"\(targetName)\" />")
        }

        for element in allHeadElements {
            output.append(element.markupString())
        }

        return Markup("<head>\(output.joined())</head>")
    }

    /// Restores reserved navigation spacing from cached values on page load.
    private var reservedNavigationSpaceScript: Script {
        Script(code: """
        (function() {
            const cachedTop = localStorage.getItem('reserved-space-top');
            const cachedBottom = localStorage.getItem('reserved-space-bottom');
            if (cachedTop) document.documentElement.style.setProperty('--reserved-space-top', cachedTop);
            if (cachedBottom) document.documentElement.style.setProperty('--reserved-space-bottom', cachedBottom);
        })();
        """)
    }

    /// Applies the site's color scheme immediately to avoid visual flashing.
    private var colorSchemingScript: Script? {
        guard let url = Bundle.module.url(
            forResource: "Resources/js/raptor-color-scheming",
            withExtension: "js"
        ),
            let contents = try? String(contentsOf: url, encoding: .utf8)
        else {
            BuildContext.logError(.missingSiteResource("js/raptor-color-scheming.js"))
            return nil
        }

        return Script(code: contents)
    }
}
