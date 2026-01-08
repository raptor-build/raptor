//
// ThemeGenerator.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

import Foundation

/// A renderer that converts a `ResolvedTheme` into fully realized CSS output.
struct ThemeGenerator: Sendable {
    /// The fully resolved theme containing all base, light, and dark configurations.
    private let theme: any Theme

    /// The site’s color scheme preference determining which theme variants are generated.
    private let siteColorScheme: SiteColorScheme

    /// Creates a generator for the specified resolved theme.
    /// - Parameters:
    ///   - theme: The theme to render into CSS.
    ///   - colorScheme: The site-wide color scheme preference (`.light`, `.dark`, or `.automatic`).
    init(theme: any Theme, colorScheme: SiteColorScheme) {
        self.theme = theme
        self.siteColorScheme = colorScheme
    }

    /// Generates complete CSS for all variants of the resolved theme.
    /// - Returns: A single CSS string representing base, light, and dark variants.
    func generate() async -> String {
        let resolved = theme.resolved
        async let base = generateVariant(for: .any, using: resolved.baseConfiguration)
        async let light = generateVariant(for: .light, using: resolved.lightOnlyConfiguration)
        async let dark = generateVariant(for: .dark, using: resolved.darkOnlyConfiguration)

        return await [base, light, dark]
            .filter { !$0.isEmpty }
            .joined(separator: "\n\n")
    }

    /// Generates the complete CSS for a single theme variant.
    /// - Parameters:
    ///   - scheme: The color scheme variant being generated (`.any`, `.light`,
    ///     or `.dark`).
    ///   - config: The theme configuration corresponding to the given scheme.
    /// - Returns: A fully rendered CSS string for the specified theme variant.
    private func generateVariant(
        for scheme: ThemeColorScheme,
        using config: ThemeConfiguration
    ) -> String {
        let selector = selector(for: scheme)
        let inlineCode = buildInlineCodeRules(from: config, selector: selector, scheme: scheme)
        let base = [Ruleset(selector) { buildVariables(for: config) }]
        let typography = buildResponsiveTypographyQueries(from: config, selector: selector)
        let smoothing = buildFontSmoothingRules(from: config, selector: selector)

        let blocks: [any CSS] = base + typography + smoothing + inlineCode
        return blocks.map { $0.render() }.joined(separator: "\n\n")
    }

    /// Builds all base-level CSS variables for a theme configuration.
    /// - Parameter config: The theme configuration to render.
    /// - Returns: A flat array of inline styles representing CSS variable definitions.
    private func buildVariables(for config: ThemeConfiguration) -> [Property] {
        var styles: [Property] = []
        styles += buildColorVariables(from: config)
        styles += buildTypographyVariables(from: config)

        if let syntaxTheme = config.syntaxHighlighterTheme {
            styles.append(.variable("highlighter-theme", value: "\"\(syntaxTheme.id)\""))
        }

        if let inlineTheme = config.inlineCodeTheme {
            styles.append(.variable("inline-highlighter-theme", value: "\"\(inlineTheme.id)\""))
        }

        if let maxContentWidth = config.maxContentWidth {
            styles.append(.variable("content-max-width", value: maxContentWidth.css))
        }

        return styles
    }

    /// Builds CSS variable definitions for theme colors.
    /// - Parameter config: The theme configuration to render.
    /// - Returns: Color-related CSS variable definitions.
    private func buildColorVariables(from config: ThemeConfiguration) -> [Property] {
        let pairs: [(ThemeVariable, String?)] = [
            (.accent, config.accent?.description),
            (.foreground, config.foreground?.description),
            (.background, config.backgroundColor?.description),
            (.backgroundGradient, config.backgroundGradient?.description)
        ]

        return pairs.compactMap { variable, color in
            guard let color else { return nil }
            return .custom(variable.rawValue, value: color)
        }
    }

    /// Builds CSS variable definitions for typography.
    /// - Parameter config: The theme configuration to render.
    /// - Returns: Typography-related CSS variable definitions.
    private func buildTypographyVariables(from config: ThemeConfiguration) -> [Property] {
        var styles = [Property]()

        let fonts: [(ThemeVariable, Font?)] = [
            (.bodyFont, config.font),
            (.monospaceFont, config.monospaceFont),
            (.headingFont, config.headingFont)
        ]

        for case let (variable, font?) in fonts {
            styles.append(.init(variable, value: "'\(font.description)'"))
        }

        styles += buildFontSizeVariables(from: config, at: .compact)

        // Line-height variables mapped to theme configuration
        let lineHeights: [(ThemeVariable, Double?)] = [
            (.bodyLineHeight, config.bodyLineSpacing),
            (.h1LineHeight, config.h1LineSpacing),
            (.h2LineHeight, config.h2LineSpacing),
            (.h3LineHeight, config.h3LineSpacing),
            (.h4LineHeight, config.h4LineSpacing),
            (.h5LineHeight, config.h5LineSpacing),
            (.h6LineHeight, config.h6LineSpacing),
            (.codeBlockLineHeight, config.codeBlockLineSpacing)
        ]

        for case let (variable, spacing?) in lineHeights {
            styles.append(
                .init(variable, value: spacing.formatted(.nonLocalizedDecimal))
            )
        }

        // Font-weight variables mapped to theme configuration
        let fontWeights: [(ThemeVariable, Font.Weight?)] = [
            (.bodyWeight, config.bodyWeight),
            (.h1Weight, config.h1Weight),
            (.h2Weight, config.h2Weight),
            (.h3Weight, config.h3Weight),
            (.h4Weight, config.h4Weight),
            (.h5Weight, config.h5Weight),
            (.h6Weight, config.h6Weight),
            (.codeBlockWeight, config.codeBlockWeight)
        ]

        for case let (variable, weight?) in fontWeights {
            styles.append(
                .init(variable, value: weight.description)
            )
        }

        return styles
    }

    /// Builds CSS rules that apply font-smoothing preferences defined in a theme configuration.
    /// - Parameters:
    ///   - config: The theme configuration containing the font-smoothing settings.
    ///   - selector: The CSS selector scoping the theme (e.g. `[data-theme="my-theme"]`).
    /// - Returns: An array of `Ruleset` objects representing body and heading font-smoothing rules.
    private func buildFontSmoothingRules(
        from config: ThemeConfiguration,
        selector: Selector
    ) -> [Ruleset] {
        var rules: [Ruleset] = []

        if let smoothing = config.fontSmoothing?.styles, !smoothing.isEmpty {
            rules.append(
                Ruleset(.element("body").whenDescendant(of: selector), styles: smoothing)
            )
        }

        if let headingSmoothing = config.headingFontSmoothing?.styles, !headingSmoothing.isEmpty {
            let headingSelector = Selector
                .element("h1")
                .or(.element("h2"), .element("h3"), .element("h4"), .element("h5"), .element("h6"))
                .whenDescendant(of: selector)

            rules.append(
                Ruleset(headingSelector, styles: headingSmoothing)
            )
        }

        return rules
    }

    /// Builds CSS variable definitions for typography font sizes at a given breakpoint.
    /// - Parameters:
    ///   - config: The theme configuration containing responsive font size values.
    ///   - breakpoint: The breakpoint whose font sizes should be extracted.
    /// - Returns: Inline styles for font-size variables at the given breakpoint.
    private func buildFontSizeVariables(
        from config: ThemeConfiguration,
        at size: HorizontalSizeClass
    ) -> [Property] {

        let fontSizes: [(ThemeVariable, DynamicValues<LengthUnit>?)] = [
            (.bodyFontSize, config.bodyFontSize),
            (.h1FontSize, config.h1Size),
            (.h2FontSize, config.h2Size),
            (.h3FontSize, config.h3Size),
            (.h4FontSize, config.h4Size),
            (.h5FontSize, config.h5Size),
            (.h6FontSize, config.h6Size),
            (.codeBlockFontSize, config.codeBlockFontSize)
        ]

        return fontSizes.compactMap { variable, values in
            guard let value = values?.values[size] else { return nil }
            return .custom(variable.rawValue, value: value.description)
        }
    }

    /// Maps responsive values to CSS variable definitions for each breakpoint.
    /// - Parameters:
    ///   - values: The responsive values to map (e.g. widths or breakpoints).
    ///   - mapping: An array mapping breakpoints to theme variables.
    /// - Returns: Inline styles for each responsive variable mapping.
    private func buildResponsiveTypographyQueries(
        from config: ThemeConfiguration,
        selector: Selector
    ) -> [MediaQuery] {
        HorizontalSizeClass.allCases
            .dropFirst() // skip compact; base already emitted
            .compactMap { size in
                let styles = buildFontSizeVariables(from: config, at: size)
                guard !styles.isEmpty else { return nil }

                return MediaQuery(size) {
                    Ruleset(selector) { styles }
                }
            }
    }

    /// Builds CSS rulesets for inline `<code>` elements within a theme.
    /// - Parameters:
    ///   - config: The theme configuration providing the inline code style.
    ///   - selector: The selector used to scope the generated rules.
    ///   - scheme: The color scheme used when resolving style variants.
    /// - Returns: An array of `Ruleset` objects defining inline code styles.
    private func buildInlineCodeRules(
        from config: ThemeConfiguration,
        selector: Selector,
        scheme: ThemeColorScheme
    ) -> [Ruleset] {
        guard let style = config.inlineCodeStyle?.wrapped else { return [] }

        let codeSelector = Selector.element("code")
            .with(
                .not(
                    .element("code").whenDescendant(of: .element("pre")),
                    .element("code").whenChild(of: .element("pre"))
                )
            )

        let fullSelector = codeSelector.whenDescendant(of: selector)

        let manager = StyleGenerator(themes: [theme])
        let cssBlocks = manager.css(for: style, environment: scheme.environmentConditions)

        return cssBlocks.compactMap { css in
            if var ruleset = css as? Ruleset {
                ruleset.selector = fullSelector
                return ruleset
            }
            return nil
        }
    }

    /// Returns a selector used to scope theme variables for a given color scheme.
    /// - Parameter scheme: The color scheme for which to generate the selector.
    /// - Returns: A selector targeting `[data-theme]` and, for light/dark variants,
    ///   also `[data-color-scheme]`.
    private func selector(for scheme: ThemeColorScheme) -> Selector {
        var selector = Selector.attribute("data-theme", value: theme.cssID)
        if scheme != .any {
            selector = selector.with(.attribute("data-color-scheme", value: scheme.rawValue))
        }
        return selector
    }
}

private extension Property {
    init(_ variable: ThemeVariable, value: String) {
        self = .custom(variable.rawValue, value: value)
    }
}
