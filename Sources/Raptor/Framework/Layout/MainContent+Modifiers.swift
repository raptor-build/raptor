//
// MainContent+Modifiers.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

public extension Main {
    /// Adds a data attribute to the element.
    /// - Parameters:
    ///   - name: The name of the data attribute
    ///   - value: The value of the data attribute
    /// - Returns: The modified `Body` element
    func data(_ name: String, _ value: String) -> Self {
        var copy = self
        copy.bodyAttributes.data.append(.init(name: name, value: value))
        return copy
    }

    /// Adds a custom attribute to the element.
    /// - Parameters:
    ///   - name: The name of the custom attribute
    ///   - value: The value of the custom attribute
    /// - Returns: The modified `HTML` element
    func attribute(_ name: String, _ value: String) -> Self {
        var copy = self
        copy.bodyAttributes.append(customAttributes: .init(name: name, value: value))
        return copy
    }
}

public extension Main {
    /// Applies vertical margin to this page container.
    /// Defaults to 20 pixels.
    func margin(_ amount: Int = 20) -> Self {
        margin(.vertical, amount)
    }

    /// Applies margin on selected vertical edges.
    /// - Parameters:
    ///   - edges: The vertical edges where this margin should be applied.
    ///   - amount: The amount of margin in pixels.
    func margin(_ edges: Edge, _ amount: Int) -> Self {
        let styles = edges.spacingStyles(amount: "\(amount)px")
        var copy = self
        copy.attributes.append(styles: styles)
        return copy
    }

    /// Sets a solid background color for the current page.
    /// - Parameter color: The background color to apply.
    /// - Returns: A modified element that registers the background color
    ///   with the active rendering context.
    func background(_ color: Color?) -> Self {
        BuildContext.registerBackground(color)
        return self
    }

    /// Sets a gradient background for the current page.
    /// - Parameter gradient: The gradient to apply as the background.
    /// - Returns: A modified element that registers the background gradient
    ///   with the active rendering context.
    func background(_ gradient: Gradient?) -> Self {
        BuildContext.registerBackground(gradient)
        return self
    }

    /// Extends the site's content to the full width of the viewport.
    /// - Returns: A copy of the current element that ignores page gutters.
    func ignorePageGutters() -> Self {
        var copy = self
        copy.bodyAttributes.remove(classes: "container")
        return copy
    }
}

public extension Main {
    /// Disables framework-provided metadata, social sharing tags, and system assets.
    ///
    /// When disabled, the document still includes essential HTML identity metadata
    /// (such as charset, viewport, title, and canonical URL), but omits Raptor’s
    /// runtime CSS, JavaScript, generator metadata, and social preview tags.
    ///
    /// - Returns: A new `Head` instance with standard framework headers disabled.
    func standardHeadersDisabled() -> Self {
        var copy = self
        copy.head.includesStandardHeaders = false
        return copy
    }

    /// Sets the default target for all links in the document.
    /// - Parameter destination: The destination all links should open in.
    /// - Returns: A new `Head` instance with the specified base target.
    func defaultLinkOpenBehavior(_ destination: LinkOpenBehavior) -> Self {
        var copy = self
        copy.head.defaultLinkTarget = destination
        return copy
    }
}

public extension Main {
    /// Adds a script file that will be loaded when the page is displayed.
    /// - Parameter file: The path or URL of the script to load.
    /// - Returns: A modified `Main` that includes the script.
    func script(_ file: String) -> Self {
        var copy = self
        copy.head.extras.append(Script(file: file))
        return copy
    }

    /// Adds custom JavaScript that will run when the page loads.
    /// - Parameter code: The JavaScript source to include.
    /// - Returns: A modified `Main` that includes the script.
    func script(code: String) -> Self {
        var copy = self
        copy.head.extras.append(Script(code: code))
        return copy
    }

    /// Adds an external script with configurable loading behavior.
    /// - Parameters:
    ///   - file: The script file to load.
    ///   - configure: A closure for customizing how the script loads.
    /// - Returns: A modified `Main` that includes the configured script.
    func script(
        _ file: String,
        configure: (ScriptConfiguration) -> ScriptConfiguration
    ) -> Self {
        var copy = self
        let config = configure(ScriptConfiguration(file: file))
        copy.head.extras.append(Script(config))
        return copy
    }

    /// Adds inline JavaScript with configurable loading behavior.
    /// - Parameters:
    ///   - code: The JavaScript to embed.
    ///   - configure: A closure for customizing how the script loads.
    /// - Returns: A modified `Main` that includes the configured script.
    func script(
        code: String,
        configure: (ScriptConfiguration) -> ScriptConfiguration
    ) -> Self {
        var copy = self
        let config = configure(ScriptConfiguration(code: code))
        copy.head.extras.append(Script(config))
        return copy
    }

    /// Adds an analytics integration to the page.
    /// - Parameter service: The analytics provider to activate.
    /// - Returns: A modified `Main` with analytics enabled.
    func analytics(_ service: AnalyticsService) -> Self {
        var copy = self
        copy.head.extras.append(Analytics(service))
        return copy
    }
}

public extension Main {
    /// Specifies the primary, authoritative URL for this page.
    ///
    /// Search engines use the canonical URL to understand which address
    /// should be treated as the original when the same content appears at
    /// multiple URLs.
    ///
    /// - Parameter url: The preferred public URL for this page.
    /// - Returns: A modified `Main` with the canonical URL set.
    func canonicalURL(_ url: String) -> Self {
        var copy = self
        copy.head.elements[.canonicalURL] = Resource(href: url, rel: "canonical")
        return copy
    }

    /// Sets the title shown when someone shares a link to this page.
    ///
    /// This affects how the page appears in social platforms, chat apps,
    /// and other services that generate link preview cards.
    ///
    /// - Parameter text: The title to display in the preview.
    /// - Returns: A modified `Main` with the sharing title applied.
    func shareLinkTitle(_ text: String) -> Self {
        var copy = self
        copy.head.elements[.openGraphTitle] = Metadata(.openGraphTitle, content: text)
        copy.head.elements[.twitterTitle] = Metadata(.twitterTitle, content: text)
        return copy
    }

    /// Sets the descriptive text shown in link preview cards.
    ///
    /// This makes shared links more informative, helping users understand
    /// what the page is about before opening it.
    ///
    /// - Parameter text: The description to appear in link previews.
    /// - Returns: A modified `Main` with the sharing description applied.
    func shareLinkDescription(_ text: String) -> Self {
        var copy = self
        copy.head.elements[.openGraphDescription] = Metadata(.openGraphDescription, content: text)
        copy.head.elements[.twitterDescription] = Metadata(.twitterDescription, content: text)
        return copy
    }

    /// Sets the image displayed when this page is shared.
    ///
    /// This image appears in preview cards on social platforms, messaging
    /// apps, and any system that displays a visual summary for shared links.
    ///
    /// - Parameter url: A publicly accessible image URL.
    /// - Returns: A modified `Main` with the sharing image applied.
    func shareLinkImage(_ url: String) -> Self {
        var copy = self
        copy.head.elements[.openGraphImage] = Metadata(.openGraphImage, content: url)
        copy.head.elements[.twitterImage] = Metadata(.twitterImage, content: url)
        return copy
    }

    /// Disables tracking for platforms that support privacy-respecting
    /// link previews, such as X.
    ///
    /// This prevents certain analytics identifiers from being sent when
    /// the page is displayed inside link preview components.
    ///
    /// - Returns: A modified `Main` with sharing-related tracking disabled.
    func shareLinkTrackingDisabled() -> Self {
        var copy = self
        copy.head.elements[.twitterDoNotTrack] = Metadata(.twitterDoNotTrack, content: "on")
        return copy
    }

    /// Prevents the user from zooming the page on devices that support
    /// pinch-to-zoom or double-tap zoom gestures.
    ///
    /// This locks the page to its initial zoom level, which can be useful for
    /// designs that must remain at a fixed scale.
    ///
    /// - Returns: A modified `Main` with zooming disabled.
    func zoomGesturesDisabled(_ isDisabled: Bool = true) -> Self {
        var copy = self
        if isDisabled {
            copy.head.elements[.viewport] = Metadata(.viewport, content: "initial-scale=1, user-scalable=no")
        } else {
            copy.head.elements[.viewport] = Metadata.flexibleViewport
        }
        return copy
    }

    /// Sets the character encoding used to interpret the page’s text.
    ///
    /// UTF-8 is typically recommended, but other encodings can be used if
    /// required for legacy content or specific languages.
    ///
    /// - Parameter encoding: The encoding identifier, such as `"utf-8"`.
    /// - Returns: A modified `Main` with the character set applied.
    func characterSet(_ encoding: String) -> Self {
        var copy = self
        copy.head.elements[.characterEncoding] = Metadata(characterSet: encoding)
        return copy
    }

    /// Prevents the page from being indexed by search engines.
    ///
    /// This is useful for preview pages, drafts, or content that should not
    /// appear in search results.
    ///
    /// - Returns: A modified `Main` configured to block indexing.
    func searchIndexingDisabled() -> Self {
        var copy = self
        copy.head.elements[.robots] = Metadata(name: "robots", content: "noindex")
        return copy
    }

    /// Removes automatic generator metadata added by Raptor.
    ///
    /// This hides the “generated by” identifier for cases where you prefer
    /// not to expose implementation details in the final output.
    ///
    /// - Returns: A modified `Main` with generator metadata removed.
    func generatorSignatureDisabled(_ isDisabled: Bool = true) -> Self {
        var copy = self
        if isDisabled {
            copy.head.elements.removeValue(forKey: .generator)
        } else {
            copy.head.elements[.generator] = Metadata.generator
        }
        return copy
    }
}

public extension Main {
    /// Defines a security policy that controls what external content
    /// the browser is allowed to load for this page.
    ///
    /// A content security policy helps prevent cross-site scripting,
    /// data injection, and other classes of security vulnerabilities.
    /// You can specify directives such as allowed script sources,
    /// permitted image locations, or whether inline scripts are allowed.
    ///
    /// - Parameter policy: A complete Content Security Policy string.
    /// - Returns: An updated `Main` value with the policy applied.
    func contentSecurityPolicy(_ policy: String) -> Self {
        var copy = self
        copy.head.elements[.contentSecurityPolicy] =
        Metadata(httpEquivalent: "content-security-policy", content: policy)
        return copy
    }

    /// Adds a custom HTTP-equivalent metadata instruction to the page.
    /// This should be used for uncommon or experimental behaviors that
    /// are not covered by the built-in modifiers.
    ///
    /// - Parameters:
    ///   - name: The `http-equiv` directive name.
    ///   - value: The value assigned to the directive.
    /// - Returns: An updated `Main` value containing the metadata.
    func httpDirective(_ name: String, _ value: String) -> Self {
        var copy = self
        copy.head.extras.append(Metadata(httpEquivalent: name, content: value))
        return copy
    }

    /// Adds a custom `<meta name="…">` element to the document's `<head>`.
    ///
    /// Use this modifier to include metadata not covered by Raptor’s built-in
    /// convenience APIs, such as proprietary verification keys, custom viewport
    /// parameters, or specialized directives.
    ///
    /// - Parameters:
    ///   - name: The value used for the `name` attribute of the `<meta>` element.
    ///   - content: The value used for the `content` attribute.
    /// - Returns: A modified `Main` instance with the metadata added.
    func pageMetadata(_ name: String, _ content: String) -> Self {
        var copy = self
        copy.head.extras.append(Metadata(name: name, content: content))
        return copy
    }
}

public extension Main {
    /// Adds a `<link>` element to the document’s metadata.
    ///
    /// Use this modifier to include external resources such as stylesheets,
    /// icons, preconnect hints, or other linked assets.
    ///
    /// - Parameters:
    ///   - href: The resource URL or path to load.
    ///   - relationship: How the resource relates to this page.
    /// - Returns: A modified `Main` containing the link.
    func pageResource(_ href: String, relationship: LinkRelationship) -> Self {
        var copy = self
        copy.head.extras.append(Resource(href: href, rel: relationship))
        return copy
    }

    /// Adds a `<link>` element with configurable attributes.
    ///
    /// Use this modifier when additional attributes—such as `crossorigin`,
    /// integrity metadata, or preload hints—should be applied to the link.
    ///
    /// - Parameters:
    ///   - href: The resource URL or path to load.
    ///   - relationship: The relationship between the resource and this page.
    ///   - configure: A closure that customizes the link configuration.
    /// - Returns: A modified `Main` containing the configured link.
    func pageResource(
        _ href: String,
        relationship: LinkRelationship,
        configure: (MetaLinkConfiguration) -> MetaLinkConfiguration
    ) -> Self {
        var copy = self

        let finalConfig = configure(
            MetaLinkConfiguration(href: href, relationship: relationship)
        )

        var link = Resource(href: finalConfig.href, rel: finalConfig.relationship)
        link.attributes.merge(finalConfig.attributes)
        copy.head.extras.append(link)

        return copy
    }
}
