//
// EnvironmentEffectConfiguration.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

/// A fully-resolved environment effect containing all effect variants.
///
/// After a variant is expanded for every case of an environment value,
/// the system stores the results in this configuration. Each entry in `cases`
/// represents the properties that apply when the environment matches that value.
///
/// The configuration is registered as a single CSS class whose output becomes
/// multiple media-scoped blocks during CSS generation.
struct EnvironmentEffectConfiguration<V: EnvironmentEffectValue>: ScopedStyleRepresentable {
    /// All resolved effect outputs, keyed by environment case.
    let casedStyles: OrderedDictionary<V, [Property]>
}

extension EnvironmentEffectConfiguration {
    /// An environment-driven effect configuration and expands it into variants.
    var scopedStyle: ScopedStyle {
        var variants = [ScopedStyleVariant]()
        let baseClass = "env-\(id)"

        for case let (value, properties) in casedStyles {
            let mediaFeatures: [MediaFeature]

            if let ranged = value as? any RangedMediaFeatureConvertible {
                mediaFeatures = ranged.mediaFeatures
            } else if let feature = value as? MediaFeature {
                mediaFeatures = [feature]
            } else {
                continue
            }

            let variant = ScopedStyleVariant(
                selector: .class(baseClass),
                mediaFeatures: mediaFeatures,
                styleProperties: OrderedSet(properties)
            )

            variants.append(variant)
        }

        return ScopedStyle(baseClass: baseClass, variants: variants)
    }
}

extension EnvironmentEffectConfiguration {
    /// Builds an environment effect configuration by expanding a transform
    /// across all cases of an environment value.
    /// - Parameter transform: A closure that receives an empty effect and a
    ///   specific environment case, and returns the modified effect for that case.
    /// - Returns: A configuration containing all resolved case-specific properties.
    static func expandedConfiguration(
        from transform: (EmptyEnvironmentEffect, V) -> EmptyEnvironmentEffect
    ) -> Self {
        let casedStyles = OrderedDictionary<V, [Property]>(
            uniqueKeysWithValues: V.allCases.compactMap { valueCase in
                let proxy = transform(EmptyEnvironmentEffect(), valueCase)
                guard !proxy.properties.isEmpty else { return nil }
                return (valueCase, proxy.properties)
            }
        )

        return .init(casedStyles: casedStyles)
    }
}
