//
// StyleGenerator+ScopedStyles.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

extension StyleGenerator {
    /// Renders all CSS blocks for a resolved variant set, including inline and attached styles.
    /// - Parameters:
    ///   - resolved: The resolved set of variants for a component or effect.
    ///   - themes: The list of active themes to scope output under.
    /// - Returns: An array of rendered CSS blocks.
    func renderVariants(
        _ resolved: ScopedStyle,
        themes: [any Theme]
    ) -> OrderedSet<String> {
        var cssBlocks = OrderedSet<String>()

        for variant in resolved.variants {
            let variantSelector = variant.selector

            let variantRule = renderVariant(
                variant,
                selector: variantSelector)

            cssBlocks.append(contentsOf: variantRule)

            let globalStyleRules = renderGlobalStyles(
                for: variant,
                baseSelector: variantSelector,
                themes: themes
            )

            cssBlocks.append(contentsOf: globalStyleRules)
        }

        return cssBlocks
    }

    /// Renders CSS rules for a scoped style variant.
    /// - Parameters:
    ///   - variant: The scoped style variant to render.
    ///   - selector: The base selector for the variant.
    /// - Returns: An array of rendered CSS rule blocks.
    private func renderVariant(
        _ variant: ScopedStyleVariant,
        selector: Selector
    ) -> [String] {
        let rules = Ruleset(
            selector,
            styles: resolvedProperties(for: variant)
        )

        return if variant.mediaFeatures.isEmpty {
            [rules.render()]
        } else {
            [MediaQuery(variant.mediaFeatures) { rules }.render()]
        }
    }

    /// Resolves the final list of CSS properties for a variant, applying `!important`
    /// where required.
    /// - Parameter variant: The scoped style variant whose properties are being resolved.
    /// - Returns: An array of resolved CSS properties.
    private func resolvedProperties(
        for variant: ScopedStyleVariant
    ) -> [Property] {
        variant.styleProperties.map { property in
            variant.important
            ? .custom(property.name, value: "\(property.value) !important")
            : property
        }
    }

    /// Renders all global `Style` implementations for a variant, including conditional environment rules.
    /// - Parameters:
    ///   - style: The variant style containing attached class names.
    ///   - baseSelector: The selector for the variant.
    ///   - themes: The list of active themes.
    /// - Returns: A list of rendered CSS blocks.
    private func renderGlobalStyles(
        for style: ScopedStyleVariant,
        baseSelector: Selector,
        themes: [any Theme]
    ) -> [String] {
        var cssBlocks: [String] = []

        for className in style.styles {

            guard let raw = rawStyles.first(where: { $0.className == className }) else {
                continue
            }

            let resolved = resolve(raw)
            let globalStyleSelector = baseSelector.with(.class(className))

            if !resolved.baseStyles.isEmpty {
                cssBlocks.append(
                    Ruleset(globalStyleSelector, styles: resolved.baseStyles).render()
                )
            }

            let conditionalBlocks = renderGlobalStyle(resolved, selector: globalStyleSelector)

            cssBlocks.append(contentsOf: conditionalBlocks)
        }

        return cssBlocks
    }

    /// Renders a single resolved `Style` based on theme, color scheme, and media features.
    /// - Parameters:
    ///   - resolved: The resolved attached styles for the class.
    ///   - attachSelector: The full selector that applies the class.
    /// - Returns: An array of rendered CSS blocks.
    private func renderGlobalStyle(
        _ resolved: ResolvedStyle,
        selector: Selector
    ) -> [String] {
        var cssBlocks: [String] = []

        for (environment, styleProperties) in resolved.conditionalStyles {
            var selector = selector

            if let theme = environment.theme {
                selector = selector.whenDescendant(
                    of: Selector.attribute("data-theme", value: theme.cssID)
                )
            }

            if let scheme = environment.colorScheme {
                selector = selector.whenDescendant(
                    of: Selector.attribute("data-color-scheme", value: scheme.rawValue)
                )
            }

            let rules = Ruleset(selector, styles: styleProperties)

            if environment.asMediaFeatures.isEmpty {
                cssBlocks.append(rules.render())
            } else {
                cssBlocks.append(
                    MediaQuery(environment.asMediaFeatures) { rules }.render()
                )
            }
        }

        return cssBlocks
    }
}
