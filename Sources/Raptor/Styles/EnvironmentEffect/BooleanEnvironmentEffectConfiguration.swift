//
// BooleanEnvironmentEffectConfiguration.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

/// A resolved configuration for a boolean-driven environment effect.
///
/// This configuration generates styles that apply only when the
/// associated boolean condition evaluates to `true`.
struct BooleanEnvironmentEffectConfiguration: ScopedStyleRepresentable {
    /// The boolean condition that activates this effect.
    let casedStyles: OrderedDictionary<BooleanEnvironmentCondition, [Property]>

    /// Expands each boolean case into its own scoped style variant.
    var scopedStyle: ScopedStyle {
        let baseClass = "env-\(id)"
        let variants = casedStyles.map { condition, properties in
            ScopedStyleVariant(
                selector: .class(baseClass),
                mediaFeatures: condition.mediaFeatures,
                styleProperties: OrderedSet(properties)
            )
        }

        return ScopedStyle(baseClass: baseClass, variants: variants)
    }
}

extension BooleanEnvironmentEffectConfiguration {
    /// Builds an environment effect configuration by expanding a transform
    /// across all cases of an environment value.
    /// - Parameter transform: A closure that receives an empty effect and a
    ///   specific environment case, and returns the modified effect for that case.
    /// - Returns: A configuration containing all resolved case-specific properties.
    static func expandedConfiguration(
        keyPath: KeyPath<BooleanEnvironmentEffectValues, BooleanEnvironmentKey>,
        from transform: (EmptyEnvironmentEffect, Bool) -> EmptyEnvironmentEffect
    ) -> Self {
        let key = BooleanEnvironmentEffectValues()[keyPath: keyPath]
        let dimension = BooleanEnvironmentKey.allValues[key]!
        let casedStyles = OrderedDictionary<BooleanEnvironmentCondition, [Property]>(
            uniqueKeysWithValues: [(true, dimension.true), (false, dimension.false)]
                .compactMap { isTrue, condition in
                    let proxy = transform(EmptyEnvironmentEffect(), isTrue)
                    return proxy.properties.isEmpty
                        ? nil
                        : (condition, proxy.properties)
                }
        )

        return .init(casedStyles: casedStyles)
    }
}
