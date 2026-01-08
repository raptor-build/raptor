//
// AttributeEnvironmentEffectValue.swift
// Raptor Build
// https://raptor.build
// See LICENSE for license information.
//

struct AttributeEnvironmentEffectConfiguration: ScopedStyleRepresentable {
    /// Styles keyed by attribute value.
    let casedStyles: OrderedDictionary<Selector, [Property]>

    var scopedStyle: ScopedStyle {
        let baseClass = "env-\(id)"

        let variants = casedStyles.map { value, properties in
            let selector = Selector.class(baseClass)
                .whenDescendant(of: value)

            return ScopedStyleVariant(
                selector: selector,
                styleProperties: OrderedSet(properties)
            )
        }

        return ScopedStyle(baseClass: baseClass, variants: variants)
    }
}

extension AttributeEnvironmentEffectConfiguration {
    /// Expands an attribute-based environment effect across all known values.
    static func expandedConfiguration<V: AttributeEnvironmentEffectValue>(
        for type: V.Type,
        from transform: (EmptyEnvironmentEffect, V) -> EmptyEnvironmentEffect
    ) -> Self {
        let casedStyles: OrderedDictionary<Selector, [Property]> =
        OrderedDictionary(
            uniqueKeysWithValues: V.allCases.compactMap { value in
                let proxy = transform(EmptyEnvironmentEffect(), value)
                guard !proxy.properties.isEmpty else { return nil }
                return (value.selector, proxy.properties)
            }
        )

        return .init(casedStyles: casedStyles)
    }
}
