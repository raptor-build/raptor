//
// StyleGenerator.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

/// A manager responsible for analyzing `Style` implementations and generating
/// optimized CSS output across different environment conditions.
package struct StyleGenerator: Sendable {
    /// Represents all environment traits that can influence style rendering.
    private enum EnvironmentTrait: CaseIterable {
        case colorScheme, motion, contrast, transparency
        case orientation, displayMode, breakpoint, theme
    }

    /// The available themes used during CSS generation.
    package var themes: [any Theme] = []

    /// Registered reusable global `Style` definitions.
    package var rawStyles: [any Style] = []

    /// Registered component-specific styles (static + phased).
    package var scopedStyles: [ScopedStyle] = []

    package init(
        themes: [any Theme] = [],
        rawStyles: [any Style] = [],
        scopedStyles: [ScopedStyle] = []
    ) {
        self.themes = themes
        self.rawStyles = rawStyles
        self.scopedStyles = scopedStyles
    }

    /// Generates complete, site-wide CSS for all registered `Style` and component definitions.
    /// - Parameter themes: The list of active `Theme` instances used during style resolution.
    ///   These themes influence environment conditions (such as color scheme or contrast)
    ///   and determine which style variants are rendered.
    /// - Returns: A concatenated CSS string containing all rendered style and component rules,
    ///   suitable for direct output to a `.css` file or inline `<style>` block.
    package func generate() async -> String {
        async let stylesCSS = generateStyleCSS()
        let phasedElementCSS = generateComponentCSS()

        return await [stylesCSS, phasedElementCSS]
            .filter { !$0.isEmpty }
            .joined(separator: "\n\n")
    }

    /// Generates CSS for all registered styles and components.
    /// - Parameter themes: The list of themes available during generation.
    /// - Returns: A concatenated CSS string.
    private func generateStyleCSS() async -> String {
        return await withTaskGroup(of: String?.self) { group in
            for style in rawStyles {
                group.addTask { await self.render(style) }
            }

            var cssBlocks: [String] = []
            for await result in group {
                if let css = result { cssBlocks.append(css) }
            }

            return cssBlocks.joined(separator: "\n\n")
        }
    }

    /// Generates complete CSS for all registered style components, including both static and phased types.
    /// - Parameter themes: The list of active themes used to resolve environment-specific styles.
    /// - Returns: A combined CSS string for all registered components.
    func generateComponentCSS() -> String {
        var cssBlocks = OrderedSet<String>()

        for entry in scopedStyles {
            cssBlocks.append(contentsOf: renderVariants(entry, themes: themes))
        }

        return cssBlocks.joined(separator: "\n\n")
    }

    /// Resolves a reusable `Style` definition into base and conditional inline styles.
    /// - Parameter style: The `Style` to resolve.
    /// - Returns: The resolved inline styles and environment variants.
    func resolve(_ style: any Style) -> ResolvedStyle {
        let baseEnvironment = EnvironmentConditions()
        let baseStyles = style.style(content: .init(), environment: baseEnvironment).styles
        var conditionalStyles: [EnvironmentConditions: OrderedSet<Property>] = [:]

        for environment in generateCombinations(maxDepth: 5) {
            let styles = style.style(content: .init(), environment: environment).styles
            guard styles != baseStyles else { continue }
            let minimal = findMinimalEnvironment(for: styles, from: environment, style: style)
            conditionalStyles[minimal] = styles
        }

        return ResolvedStyle(baseStyles: baseStyles, conditionalStyles: conditionalStyles)
    }

    /// Determines the minimal set of environment conditions needed to produce a given style.
    /// - Parameters:
    ///   - targetStyles: The styles to compare.
    ///   - environment: The full environment being tested.
    ///   - style: The `Style` being analyzed.
    /// - Returns: The smallest `StyleEnvironmentConditions` producing the target style.
    private func findMinimalEnvironment(
        for targetStyles: OrderedSet<Property>,
        from environment: EnvironmentConditions,
        style: any Style
    ) -> EnvironmentConditions {
        var minimal = environment
        for remove in environment.activeTraits {
            var test = minimal
            remove(&test)
            let result = style.style(content: .init(), environment: test).styles
            if result == targetStyles { remove(&minimal) }
        }
        return minimal
    }

    /// Converts environment conditions into all valid media query combinations.
    private func generateCombinations(maxDepth: Int = 5) -> [EnvironmentConditions] {
        let traits: [(EnvironmentTrait, [Any?])] = [
            (.colorScheme, SystemColorScheme.allCases),
            (.motion, MotionProminence.allCases),
            (.contrast, ContrastLevel.allCases),
            (.transparency, TransparencyLevel.allCases),
            (.orientation, Orientation.allCases),
            (.displayMode, DisplayMode.allCases),
            (.breakpoint, HorizontalSizeClass.allCases),
            (.theme, themes.map { type(of: $0) })
        ].filter { !$0.1.isEmpty }

        var combinations: [EnvironmentConditions] = []
        let count = traits.count

        // swiftlint:disable:next cyclomatic_complexity
        func recurse(index: Int, depth: Int, current: EnvironmentConditions) {
            if depth > maxDepth || index == count { return }
            for i in index..<count {
                let (trait, values) = traits[i]
                for value in values {
                    var environment = current
                    switch trait {
                    case .colorScheme: environment.colorScheme = value as? SystemColorScheme
                    case .motion: environment.motion = value as? MotionProminence
                    case .contrast: environment.contrastLevel = value as? ContrastLevel
                    case .transparency: environment.transparencyLevel = value as? TransparencyLevel
                    case .orientation: environment.layoutOrientation = value as? Orientation
                    case .displayMode: environment.displayMode = value as? DisplayMode
                    // swiftlint:disable:next force_cast
                    case .breakpoint: environment.horizontalSizeClass = value as! HorizontalSizeClass
                    case .theme: environment.theme = value as? (any Theme.Type)
                    }
                    combinations.append(environment)
                    recurse(index: i + 1, depth: depth + 1, current: environment)
                }
            }
        }

        recurse(index: 0, depth: 1, current: EnvironmentConditions())
        return combinations
    }

    /// Renders a top-level reusable `Style` into CSS rules.
    private func render(_ style: any Style) async -> String {
        let resolved = resolve(style)
        var cssRules: OrderedSet<String> = []

        if !resolved.baseStyles.isEmpty {
            cssRules.append(Ruleset(.class(style.className), styles: resolved.baseStyles).render())
        }

        for (conditions, styleProperties) in resolved.conditionalStyles {
            let themedSelector = buildThemeSelector(
                for: style.className,
                theme: conditions.theme,
                colorScheme: conditions.colorScheme
            )

            let mediaFeatures = conditions.asMediaFeatures
            if mediaFeatures.isEmpty {
                cssRules.append(Ruleset(themedSelector, styles: styleProperties).render())
            } else {
                cssRules.append(MediaQuery(mediaFeatures) { Ruleset(themedSelector, styles: styleProperties) }.render())
            }
        }

        return cssRules.joined(separator: "\n\n")
    }

    /// Constructs a composed CSS selector scoped by theme and color scheme.
    private func buildThemeSelector(
        for className: String,
        theme: (any Theme.Type)?,
        colorScheme: SystemColorScheme?
    ) -> Selector {
        var selector = Selector.class(className)

        if let colorScheme {
            let scheme = Selector.attribute("data-color-scheme", value: colorScheme.rawValue)
            selector = selector.whenDescendant(of: scheme)
        }

        if let theme {
            let themed = Selector.attribute("data-theme", value: theme.cssID)
            selector = selector.whenDescendant(of: themed)
        }

        return selector
    }
}

extension StyleGenerator {
    /// Generates inline CSS blocks for a `Style` in a specific environment.
    /// - Parameters:
    ///   - style: The reusable style to resolve.
    ///   - environment: The environment conditions used when resolving the style.
    /// - Returns: An array of inline `CSS` blocks representing the resolved style.
    func css(for style: any Style, environment: EnvironmentConditions) -> [any CSS] {
        let styles = style.style(content: .init(), environment: environment).styles
        guard !styles.isEmpty else { return [] }
        return [Ruleset(nil, styles: styles)]
    }
}

extension EnvironmentConditions {
    /// Converts active environment settings into media query conditions.
    var asMediaFeatures: [MediaFeature] {
        var features: [MediaFeature] = []
        if let motion { features.append(motion as MediaFeature) }
        if let contrastLevel { features.append(contrastLevel as MediaFeature) }
        if let transparencyLevel { features.append(transparencyLevel as MediaFeature) }
        if let layoutOrientation { features.append(layoutOrientation as MediaFeature) }
        if let displayMode { features.append(displayMode as MediaFeature) }

        if horizontalSizeClass != .none {
            features.append(horizontalSizeClass as MediaFeature)
        }

        return features
    }
}

private extension EnvironmentConditions {
    /// Provides closures to deactivate active traits, enabling minimal condition testing.
    var activeTraits: [(inout EnvironmentConditions) -> Void] {
        var properties: [(inout EnvironmentConditions) -> Void] = []
        if colorScheme != nil { properties.append { $0.colorScheme = nil } }
        if motion != nil { properties.append { $0.motion = nil } }
        if contrastLevel != nil { properties.append { $0.contrastLevel = nil } }
        if transparencyLevel != nil { properties.append { $0.transparencyLevel = nil } }
        if layoutOrientation != nil { properties.append { $0.layoutOrientation = nil } }
        if displayMode != nil { properties.append { $0.displayMode = nil } }

        if horizontalSizeClass != .none {
            properties.append { $0.horizontalSizeClass = .none }
        }

        if theme != nil { properties.append { $0.theme = nil } }
        return properties
    }
}
