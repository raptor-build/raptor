//
// CSSManager.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

public typealias Selector = RaptorHTML.Selector

/// Manages CSS rule generation for utilities and responsive variants.
package struct CSSGenerator: Sendable {
    /// Distinguishes between block-level and inline syntax highlighting scopes.
    private enum SyntaxHighlighterScope: Sendable {
        /// Syntax highlighting applied to `<pre><code>` blocks.
        case block

        /// Syntax highlighting applied to inline `<code>` elements.
        case inline

        /// The CSS variable prefix used for this scope.
        var variablePrefix: String {
            switch self {
            case .block: "hl"
            case .inline: "inline-hl"
            }
        }

        /// Returns the attribute selector used to scope CSS variables
        /// for the given syntax highlighter theme.
        /// - Parameter theme: The syntax highlighter theme being rendered.
        /// - Returns: A selector matching elements scoped to the given theme.
        func selector(for theme: any SyntaxHighlighterTheme) -> Selector {
            switch self {
            case .block:
                .attribute("data-highlighter-theme", value: theme.id)
            case .inline:
                .attribute("data-inline-highlighter-theme", value: theme.id)
            }
        }
    }

    /// Represents a queued CSS property registration that may be scoped
    /// to one or more media queries.
    private struct ResponsiveRule {
        /// The CSS class name this rule applies to.
        let className: String

        /// Media feature queries controlling when the rule is active.
        let queries: [any MediaFeature]

        /// The CSS properties applied by this rule.
        let styles: [Property]
    }

    /// Encapsulates all information required to generate a themed CSS rule.
    private struct RuleContext {
        /// The property registration being expanded.
        let rule: ResponsiveRule

        /// The resolved site theme.
        let theme: ResolvedTheme

        /// The system color scheme (light or dark).
        let scheme: SystemColorScheme

        /// Whether multiple themes are present on the site.
        let hasMultipleThemes: Bool
    }

    /// All site themes contributing styles and design tokens.
    package let themes: [any Theme]

    /// The site-wide color scheme configuration.
    package let scheme: SiteColorScheme

    /// Font families registered for the site.
    package let fonts: OrderedSet<Font>

    /// Keyframe animations registered for this site.
    package let animations: OrderedSet<Animation>

    /// Syntax highlighting themes used to generate Prism CSS variables.
    package let syntaxHighlighterThemes: [any SyntaxHighlighterTheme]

    /// Whether language-tagged code blocks require a default
    /// syntax highlighter theme to be applied.
    private let requiresDefaultHighlighterTheme: Bool

    /// Creates a CSS generator configured with site themes and build-time assets.
    /// - Parameters:
    ///   - site: The site definition providing themes and color scheme configuration.
    ///   - buildContext: The build context supplying fonts, animations, and syntax themes.
    package init(site: any Site, buildContext: BuildContext) {
        self.themes = site.themes
        self.scheme = site.colorScheme
        self.fonts = buildContext.fonts
        self.animations = buildContext.animations

        var syntaxHighlighterThemes =
        buildContext.syntaxHighlighterThemes +
        site.allSyntaxHighlighterThemes

        self.requiresDefaultHighlighterTheme =
        !buildContext.syntaxHighlighterLanguages.isEmpty &&
        syntaxHighlighterThemes.isEmpty

        if requiresDefaultHighlighterTheme {
            BuildContext.logWarning("""
            Language-tagged code blocks are present, but no syntax-highlighter theme is defined. \
            The built-in Xcode theme has been applied so code renders correctly. \
            To customize syntax highlighting, add a syntax-highlighter theme to your site’s theme.
            """)
            syntaxHighlighterThemes.append(.xcode)
        }

        self.syntaxHighlighterThemes = syntaxHighlighterThemes
    }

    /// Generates all non–syntax-highlighting CSS assets required by the site.
    /// - Returns: A combined CSS string containing fonts, animations, and site theme rules.
    package func generateSiteCSS() async -> String {
        let fontCSS = generateFonts()
        let animationCSS = generateAnimations()
        async let themesCSS = await generateThemes()

        return await [fontCSS, animationCSS, themesCSS]
            .filter { !$0.isEmpty }
            .joined(separator: "\n\n")
    }

    /// Generates CSS variable definitions for all syntax highlighter themes.
    /// - Returns: A CSS string defining `--hl-*` and `--inline-hl-*`
    ///   variables scoped by syntax highlighter theme identifiers.
    package func generatePrismThemeCSS() -> String {
        var output = ""

        if requiresDefaultHighlighterTheme {
            output += Ruleset(
                .pseudoClass("root"),
                styles: [.variable("highlighter-theme", value: "\"\(Xcode().id)\"")]
            ).render()
        }

        output += "\n\n" + generateSyntaxHighlighterThemes()
        return output
    }

    /// Generates full theme CSS concurrently for all site themes.
    /// - Returns: A combined CSS string for all rendered site themes.
    private func generateThemes() async -> String {
        let cssBlocks = await withTaskGroup(of: String?.self, returning: [String].self) { group in
            for theme in themes {
                group.addTask { await theme.render(scheme: scheme) }
            }

            var results: [String] = []
            for await case let css? in group {
                results.append(css)
            }
            return results
        }

        return cssBlocks.joined(separator: "\n\n")
    }

    /// Generates CSS variable blocks for all unique syntax highlighter themes.
    /// - Returns: A combined CSS string defining syntax highlighting variables
    ///   for each registered highlighter theme.
    private func generateSyntaxHighlighterThemes() -> String {
        let uniqueThemes = Dictionary(
            syntaxHighlighterThemes.map { ($0.id, $0) },
            uniquingKeysWith: { first, _ in first }
        )
            .values
            .sorted { $0.id < $1.id }

        return uniqueThemes
            .flatMap { theme in
                [renderSyntaxTheme(theme, scope: .block),
                 renderSyntaxTheme(theme, scope: .inline)]
            }
            .joined(separator: "\n\n")
    }

    /// Renders a CSS ruleset defining syntax highlighting variables
    /// for a specific selector and configuration.
    /// - Parameters:
    ///   - selector: The selector scoping the variables.
    ///   - prefix: The variable name prefix (e.g. `hl` or `inline-hl`).
    ///   - configuration: The syntax highlighting colors.
    /// - Returns: A rendered CSS ruleset string.
    private func renderVariables(
        selector: Selector,
        prefix: String,
        configuration: SyntaxHighlighterThemeConfiguration
    ) -> String {
        func resolvedValue(_ color: Color?) -> String {
            (color ?? configuration.defaultColor).description
        }

        let properties: [Property] = [
            .variable("\(prefix)-bg", value: resolvedValue(configuration.backgroundColor)),
            .variable("\(prefix)-plain", value: resolvedValue(configuration.plainTextColor)),
            .variable("\(prefix)-keyword", value: resolvedValue(configuration.keywordColor)),
            .variable("\(prefix)-type", value: resolvedValue(configuration.typeColor)),
            .variable("\(prefix)-function", value: resolvedValue(configuration.functionColor)),
            .variable("\(prefix)-variable", value: resolvedValue(configuration.variableColor)),
            .variable("\(prefix)-property", value: resolvedValue(configuration.propertyColor)),
            .variable("\(prefix)-parameter", value: resolvedValue(configuration.parameterColor)),
            .variable("\(prefix)-string", value: resolvedValue(configuration.stringColor)),
            .variable("\(prefix)-number", value: resolvedValue(configuration.numberColor)),
            .variable("\(prefix)-comment", value: resolvedValue(configuration.commentColor)),
            .variable("\(prefix)-operator", value: resolvedValue(configuration.operatorColor)),
            .variable("\(prefix)-punctuation", value: resolvedValue(configuration.punctuationColor)),
            .variable("\(prefix)-annotation", value: resolvedValue(configuration.annotationColor)),
            .variable("\(prefix)-directive", value: resolvedValue(configuration.directiveColor)),
            .variable("\(prefix)-error", value: resolvedValue(configuration.errorColor)),
            .variable("\(prefix)-unlabeled-parameter", value: resolvedValue(configuration.unlabeledParameterColor)),
            .variable("\(prefix)-string-delimiter", value: resolvedValue(configuration.stringDelimiterColor)),
            .variable("\(prefix)-interpolation-delimiter",
                      value: resolvedValue(configuration.interpolationDelimiterColor))
        ]

        return Ruleset(selector, styles: properties).render()
    }

    /// Renders a CSS variable block for a single syntax highlighter theme.
    /// - Parameters:
    ///   - theme: The syntax highlighter theme being rendered.
    ///   - scope: Whether the theme applies to block or inline code.
    /// - Returns: A CSS string defining variables for the theme and scope.
    private func renderSyntaxTheme(
        _ theme: any SyntaxHighlighterTheme,
        scope: SyntaxHighlighterScope
    ) -> String {
        let resolved = theme.resolved
        let baseSelector = scope.selector(for: theme)
        let prefix = scope.variablePrefix

        var rules: [String] = []

        rules.append(
            renderVariables(
                selector: baseSelector,
                prefix: prefix,
                configuration: resolved.base
            )
        )

        if resolved.light != resolved.base {
            rules.append(
                renderVariables(
                    selector: baseSelector.with(.attribute("data-color-scheme", value: "light"))
                        .or(baseSelector.whenDescendant(of: .attribute("data-color-scheme", value: "light"))),
                    prefix: prefix,
                    configuration: resolved.light
                )
            )
        }

        if resolved.dark != resolved.base {
            rules.append(
                renderVariables(
                    selector: baseSelector.with(.attribute("data-color-scheme", value: "dark"))
                        .or(baseSelector.whenDescendant(of: .attribute("data-color-scheme", value: "dark"))),
                    prefix: prefix,
                    configuration: resolved.dark
                )
            )
        }

        return rules.joined(separator: "\n")
    }

    /// Generates all site-wide `@font-face` and `@import` rules for registered fonts.
    /// - Returns: A combined CSS string containing font declarations for all site
    ///   and theme-specific fonts.
    private func generateFonts() -> String {
        let allFonts = fonts + themes.map(\.resolved).flatMap(\.fonts)
        return buildFontRules(from: allFonts).joined(separator: "\n\n")
    }

    /// Generates all registered keyframe animations and trigger rules.
    /// - Returns: A combined CSS string containing `@keyframes` blocks and their associated animation rules.
    private func generateAnimations() -> String {
        animations
            .map { $0.render() }
            .joined(separator: "\n\n")
    }

    /// Builds `@font-face` and `@import` rules for all non-system fonts referenced by the theme.
    /// - Parameter fonts: The fonts to render into CSS.
    /// - Returns: A list of CSS strings representing `@font-face` or `@import` declarations.
    private func buildFontRules(from fonts: some Collection<Font>) -> [String] {
        let systemFonts = Font.systemFonts + Font.monospaceFonts

        let fontRules = fonts.flatMap { font -> [String] in
            guard let family = font.name,
                  !family.isEmpty,
                  !systemFonts.contains(family)
            else { return [] }

            return font.sources.compactMap { source in
                buildFontRule(for: family, source: source)
            }
        }

        return Array(OrderedSet(fontRules))
    }

    /// Builds a single `@font-face` or `@import` rule for a specific font source.
    /// - Parameters:
    ///   - family: The name of the font family.
    ///   - source: The source describing the font’s URL, weight, and style.
    /// - Returns: A CSS string representing a valid `@font-face` or `@import` rule.
    private func buildFontRule(for family: String, source: FontSource) -> String? {
        if source.url.host()?.contains("fonts.googleapis.com") == true {
            // Google Fonts → use @import
            return ImportRule(source.url).render()
        }

        // Custom / self-hosted → use @font-face
        return FontFaceRule(
            family: family,
            source: source.url,
            weight: source.weight.description,
            style: source.variant.rawValue,
            ascent: source.ascentOverride,
            descent: source.descentOverride,
            lineGap: source.lineGapOverride
        ).render()
    }

    /// Expands a registration into CSS rules for all theme/scheme combinations.
    /// - Parameters:
    ///   - registration: The registration to expand.
    ///   - themes: Available themes for the site.
    /// - Returns: CSS rules for all theme and color scheme combinations.
    private func generateRulesForAllThemes(
        _ registration: ResponsiveRule,
        themes: [ResolvedTheme]
    ) -> [String] {
        guard !registration.queries.isEmpty else {
            return [Ruleset(.class(registration.className), styles: registration.styles).render()]
        }

        let hasMultipleThemes = themes.count > 1
        var rules: [String] = []

        // Generate rules for each theme × color scheme combination
        for theme in themes {
            for scheme in SystemColorScheme.allCases {
                let context = RuleContext(
                    rule: registration,
                    theme: theme,
                    scheme: scheme,
                    hasMultipleThemes: hasMultipleThemes)

                if let rule = buildRule(context: context) {
                    rules.append(rule)
                }
            }
        }

        return rules
    }

    /// Builds a single CSS rule for a theme/scheme combination.
    /// - Parameter context: The rule generation context.
    /// - Returns: A CSS media query rule, or nil if no valid conditions exist.
    private func buildRule(context: RuleContext) -> String? {
        let conditions = context.rule.queries
        let selector = buildSelector(context: context)
        let ruleset = Ruleset(selector, styles: context.rule.styles)

        //  Return as a normal ruleset if no media queries present
        guard !conditions.isEmpty else { return ruleset.render() }

        // Wrap selector-scoped ruleset inside the @media
        return MediaQuery(conditions, combinator: .and, rulesets: [ruleset]).render()
    }

    /// Builds an appropriate selector based on theme requirements.
    /// - Parameter context: The rule generation context.
    /// - Returns: A selector with optional theme and color scheme scoping.
    private func buildSelector(context: RuleContext) -> Selector {
        guard context.hasMultipleThemes else {
            return .class(context.rule.className)
        }

        let themeAttribute = Selector.attribute("data-theme", value: context.theme.cssID)
        let schemeAttribute = Selector.attribute("data-color-scheme", value: context.scheme.rawValue)
        return .class(context.rule.className)
            .whenDescendant(of: schemeAttribute)
            .whenDescendant(of: themeAttribute)
    }
}
