//
// ThemeEnvironmentEffectConfiguration.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

struct ThemeEnvironmentEffectConfiguration: ScopedStyleRepresentable {
    /// Keyed by theme cssID internally
    let casedStyles: OrderedDictionary<String, [Property]>

    var scopedStyle: ScopedStyle {
        let baseClass = "theme-\(id)"
        let variants = casedStyles.map { cssID, properties in
            let selector = Selector.class(baseClass)
                .whenDescendant(of: .attribute("data-theme", value: cssID))

            return ScopedStyleVariant(
                selector: selector,
                styleProperties: OrderedSet(properties)
            )
        }

        return ScopedStyle(baseClass: baseClass, variants: variants)
    }
}

extension ThemeEnvironmentEffectConfiguration {
    /// Builds an environment effect configuration by expanding a transform
    /// across all cases of an environment value.
    /// - Parameter transform: A closure that receives an empty effect and a
    ///   specific environment case, and returns the modified effect for that case.
    /// - Returns: A configuration containing all resolved case-specific properties.
    static func expandedConfiguration(
        from transform: (EmptyEnvironmentEffect, any Theme) -> EmptyEnvironmentEffect
    ) -> Self {
        let themes = RenderingContext.current?.site.themes ?? []

        let casedStyles = OrderedDictionary<String, [Property]>(
            uniqueKeysWithValues: themes.map { theme in
                let proxy = transform(EmptyEnvironmentEffect(), theme)
                return (theme.cssID, proxy.properties)
            }
        )

        return .init(casedStyles: casedStyles)
    }
}
