//
// StyleGenerator+ResolvedStyle.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

extension StyleGenerator {
    /// Represents a fully resolved style definition, including both
    /// its base appearance and environment-specific variants.
    struct ResolvedStyle {
        /// The base inline styles applied under default environment conditions.
        let baseStyles: OrderedSet<Property>

        /// Additional styles that apply under specific environment conditions
        /// (e.g. dark mode, high contrast, reduced motion).
        let conditionalStyles: [EnvironmentConditions: OrderedSet<Property>]
    }
}
