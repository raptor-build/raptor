//
// ResolvedTheme.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

/// A fully resolved, immutable theme model containing all color-scheme variants.
struct ResolvedTheme: Sendable {
    /// The unique CSS identifier used for scoping theme variables in rendered output.
    let cssID: String

    /// The configuration shared between both light and dark modes.
    let baseConfiguration: ThemeConfiguration

    /// The subset of properties unique to the light color scheme.
    let lightOnlyConfiguration: ThemeConfiguration

    /// The subset of properties unique to the dark color scheme.
    let darkOnlyConfiguration: ThemeConfiguration

    /// All unique fonts referenced across all theme variants.
    let fonts: OrderedSet<Font>

    /// All syntax-highlighting themes defined across color schemes.
    let syntaxHighlighterThemes: [any SyntaxHighlighterTheme]

    /// Creates a fully resolved, immutable theme snapshot from a base `Theme`.
    /// - Parameter theme: The theme to resolve into light, dark, and base configurations.
    init(_ theme: any Theme) {
        self.cssID = theme.cssID

        let base = theme.theme(site: .init(), colorScheme: .any)

        self.baseConfiguration = base

        // Some properties (like inlineCodeStyle) are implemented as
        // reusable Styles. Those styles are later resolved by
        // StyleGenerator, based on EnvironmentConditions (including
        // color scheme). If a style is only present on the .any
        // theme configuration and *not* copied into the light/dark
        // variants, it gets resolved as a generic style with no
        // color-scheme context — which means it loses proper scoping
        // and produces incorrect CSS. To avoid that, style-based
        // properties defined on the base (.any) configuration are
        // explicitly inherited by the light and dark configurations
        // unless they override them.
        self.lightOnlyConfiguration = theme
            .theme(site: .init(), colorScheme: .light)
            .inheritingStyles(from: base)

        self.darkOnlyConfiguration = theme
            .theme(site: .init(), colorScheme: .dark)
            .inheritingStyles(from: base)

        var fontSet = OrderedSet<Font>()

        fontSet.formUnion([
            lightOnlyConfiguration.font,
            lightOnlyConfiguration.monospaceFont,
            lightOnlyConfiguration.headingFont,
            darkOnlyConfiguration.font,
            darkOnlyConfiguration.monospaceFont,
            darkOnlyConfiguration.headingFont
        ].compactMap(\.self))

        self.fonts = fontSet

        self.syntaxHighlighterThemes = [
            lightOnlyConfiguration.syntaxHighlighterTheme,
            lightOnlyConfiguration.inlineCodeTheme,
            darkOnlyConfiguration.syntaxHighlighterTheme,
            darkOnlyConfiguration.inlineCodeTheme
        ].compactMap(\.self)
    }
}

extension ThemeConfiguration {
    /// Returns a new theme configuration with `Style` values inherited from another configuration.
    /// - Parameter config: The theme configuration to inherit missing styles from.
    /// - Returns: A new `ThemeConfiguration` with the inherited `Style` values.
    func inheritingStyles(from config: ThemeConfiguration) -> ThemeConfiguration {
        var copy = self

        if copy.inlineCodeStyle == nil {
            copy.inlineCodeStyle = config.inlineCodeStyle
        }

        if copy.syntaxHighlighterTheme == nil {
            copy.syntaxHighlighterTheme = config.syntaxHighlighterTheme
        }

        return copy
    }
}
