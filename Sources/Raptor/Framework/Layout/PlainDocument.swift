//
// PlainDocument.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

import Foundation

/// An HTML document with no extra attributes applied.
public struct PlainDocument: Document {
    /// The regions of a document.
    private var regions: [any Region]

    /// Creates a plain document from the provided regions.
    /// - Parameter regions: An array of the document's regions.
    init(_ regions: [any Region]) {
        self.regions = regions
    }

    /// Creates an empty plain document.
    init() {
        self.regions = []
    }

    /// Constructs a document from an array of `Region` values supplied
    /// by a `@RegionBuilder`.
    /// - Parameter content: An array containing the document's regions.
    public init(@RegionBuilder content: () -> [any Region]) {
        self.regions = content()
    }

    public func render() -> Markup {
        let main = firstRegion(typed: Main.self)
        let banner = firstRegion(typed: Banner.self)
        let navigation = firstRegion(typed: Navigation.self)
        let footer = firstRegion(typed: Footer.self)

        var bodyMarkup = Markup()

        let headerMarkup = renderHeader(banner: banner, navigation: navigation)
        bodyMarkup += headerMarkup

        var headMarkup = Markup()
        var bodyAttributes = CoreAttributes()

        if let main {
            let mainMarkup = main.render()
            bodyMarkup += mainMarkup
            bodyAttributes = main.bodyAttributes
            // Deferred head rendering to accommodate for context updates during body rendering
            headMarkup = main.head.render()
        }

        if let footerMarkup = footer?.render() {
            bodyMarkup += footerMarkup
        }

        let config = renderingContext.site.syntaxHighlighterConfiguration

        if case .visible = config.lineNumberVisibility {
            bodyAttributes.append(classes: "line-numbers")
        }

        let body = Markup("<body\(bodyAttributes)>\(bodyMarkup.string)</body>")
        let attributes = buildDocumentAttributes()

        var output = "<!doctype html>"
        output += "<html\(attributes)>"
        output += headMarkup.string
        output += body.string
        output += "</html>"
        return Markup(output)
    }

    /// Returns the first region of the specified type from the document.
    /// - Parameter type: The region type to locate.
    /// - Returns: The first matching region, or `nil` if none exist.
    private func firstRegion<T>(typed type: T.Type) -> T? {
        let matches = regions.compactMap { $0 as? T }

        if matches.count > 1 {
            BuildContext.logWarning("""
            A Layout has multiple instances of \(String(describing: T.self)). \
            Only the first will be rendered.
            """)
        }

        return matches.first
    }

    /// Builds the root HTML attributes for the document.
    /// - Returns: A configured set of attributes for the `<html>` element.
    private func buildDocumentAttributes() -> CoreAttributes {
        var attributes = CoreAttributes()

        let defaultLocale = renderingContext.defaultLocale
        let language = defaultLocale?.asRFC5646 ?? Locale.automatic.asRFC5646
        attributes.append(customAttributes: .init(name: "lang", value: language))

        let site = renderingContext.site

        if let defaultTheme = site.themes.first {
            attributes.append(dataAttributes: .init(name: "theme", value: defaultTheme.cssID))
        }

        if site.colorScheme != .automatic {
            attributes.append(dataAttributes: .init("lock-scheme"))
            attributes.append(dataAttributes: .init(
                name: "color-scheme",
                value: site.colorScheme.rawValue
            ))
        }

        if let backgroundProperties = BuildContext.current.pageBackground?.styleProperties {
            attributes.append(styles: backgroundProperties)
        }

        return attributes
    }

    /// Renders the page header containing banner and navigation content.
    private func renderHeader(banner: Banner?, navigation: Navigation?) -> Markup {
        var banner = banner
        var navigation = navigation
        var position: Position?

        if navigation?.position == .fixedTop {
            position = .fixedTop
            navigation?.position = nil
            banner?.position = nil
        }

        var headerOutput = ""

        if let banner, !banner.isEmpty {
            headerOutput += banner.render().string
        }

        if let navigation, !navigation.isEmpty {
            headerOutput += navigation.render().string
        }

        guard !headerOutput.isEmpty else {
            return Markup()
        }

        return Tag("header") {
            headerOutput
        }
        .position(position)
        .render()
    }
}
