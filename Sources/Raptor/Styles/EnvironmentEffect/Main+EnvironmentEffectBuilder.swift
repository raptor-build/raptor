//
// Main+EnvironmentEffectBuilder.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

public extension Main {
    @resultBuilder
    enum EnvironmentEffectBuilder: Sendable {
        /// Builds a single configuration block.
        public static func buildBlock(
            _ components: EmptyEnvironmentEffect
        ) -> EmptyEnvironmentEffect {
            components
        }

        /// Enables support for conditional `if` blocks.
        public static func buildOptional(
            _ component: EmptyEnvironmentEffect?
        ) -> EmptyEnvironmentEffect {
            component ?? EmptyEnvironmentEffect()
        }

        /// Enables support for `if/else` branching.
        public static func buildEither(
            first component: EmptyEnvironmentEffect
        ) -> EmptyEnvironmentEffect {
            component
        }

        public static func buildEither(
            second component: EmptyEnvironmentEffect
        ) -> EmptyEnvironmentEffect {
            component
        }
    }
}
