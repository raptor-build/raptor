//
// EnvironmentEffectModifier.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

public extension HTML {
    /// Produces styles that vary across cases of an environment value.
    /// - Parameters:
    ///   - keyPath: A key path selecting the environment value to react to.
    ///   - transform: A closure that produces the style variant for a
    ///   specific case of the environment value. The closure receives an empty
    ///   effect and the current case, and returns the modified effect for that case.
    /// - Returns: A modified `HTML` node with a CSS class attached that
    /// references the generated environment-dependent styles.
    func environmentEffect<V: EnvironmentEffectValue>(
        _ keyPath: KeyPath<EnvironmentEffectValues, V.Type>,
        @EnvironmentEffectBuilder
        _ transform: @Sendable @escaping (EmptyEnvironmentEffect, V) -> EmptyEnvironmentEffect
    ) -> some HTML {
        let config = EnvironmentEffectConfiguration<V>.expandedConfiguration(from: transform)
        BuildContext.register(config.scopedStyle)
        return self.class(config.scopedStyle.allClasses)
    }

    /// Produces styles that vary across active site themes.
    ///
    /// This overload behaves like `environmentEffect`, but provides the
    /// concrete `Theme` instance instead of a finite environment value.
    func environmentEffect(
        _ keyPath: KeyPath<ThemeEnvironmentEffectValues, (any Theme).Type>,
        @EnvironmentEffectBuilder
        _ transform: @Sendable @escaping (EmptyEnvironmentEffect, any Theme) -> EmptyEnvironmentEffect
    ) -> some HTML {
        let config = ThemeEnvironmentEffectConfiguration.expandedConfiguration(from: transform)
        BuildContext.register(config.scopedStyle)
        return self.class(config.scopedStyle.allClasses)
    }

    /// Produces styles that respond to a boolean environment condition.
    /// - Parameters:
    ///   - keyPath: A key path selecting a boolean environment condition.
    ///   - transform: A closure that produces styles for the boolean condition.
    /// - Returns: A modified HTML node with a generated CSS class attached
    ///   when styles are produced.
    func environmentEffect(
        _ keyPath: KeyPath<BooleanEnvironmentEffectValues, BooleanEnvironmentKey>,
        @EnvironmentEffectBuilder
        _ transform: @Sendable @escaping (EmptyEnvironmentEffect, Bool) -> EmptyEnvironmentEffect
    ) -> some HTML {
        let config = BooleanEnvironmentEffectConfiguration.expandedConfiguration(keyPath: keyPath, from: transform)
        BuildContext.register(config.scopedStyle)
        return self.class(config.scopedStyle.allClasses)
    }

    /// Produces styles that vary across values of an attribute-backed environment.
    /// - Parameters:
    ///   - keyPath: A key path selecting the attribute-backed environment dimension.
    ///   - transform: Produces styles for a specific attribute value.
    /// - Returns: A modified HTML node with generated environment styles applied.
    func environmentEffect<V: AttributeEnvironmentEffectValue>(
        _ keyPath: KeyPath<AttributeEnvironmentEffectValues, V.Type>,
        @EnvironmentEffectBuilder
        _ transform: @Sendable @escaping (EmptyEnvironmentEffect, V) -> EmptyEnvironmentEffect
    ) -> some HTML {
        let config = AttributeEnvironmentEffectConfiguration
            .expandedConfiguration(for: V.self, from: transform)

        BuildContext.register(config.scopedStyle)
        return self.class(config.scopedStyle.allClasses)
    }
}

public extension InlineContent {
    /// Produces styles that vary across cases of an environment value.
    /// - Parameters:
    ///   - keyPath: A key path selecting the environment value to react to.
    ///   - transform: A closure that produces the style variant for a
    ///   specific case of the environment value. The closure receives an empty
    ///   effect and the current case, and returns the modified effect for that case.
    /// - Returns: A modified `HTML` node with a CSS class attached that
    /// references the generated environment-dependent styles.
    func environmentEffect<V: EnvironmentEffectValue>(
        _ keyPath: KeyPath<EnvironmentEffectValues, V.Type>,
        @EnvironmentEffectBuilder
        _ transform: @Sendable @escaping (EmptyEnvironmentEffect, V) -> EmptyEnvironmentEffect
    ) -> some InlineContent {
        let config = EnvironmentEffectConfiguration<V>.expandedConfiguration(from: transform)
        BuildContext.register(config.scopedStyle)
        return self.class(config.scopedStyle.allClasses)
    }

    /// Produces styles that vary across active site themes.
    ///
    /// This overload behaves like `environmentEffect`, but provides the
    /// concrete `Theme` instance instead of a finite environment value.
    func environmentEffect(
        _ keyPath: KeyPath<ThemeEnvironmentEffectValues, (any Theme).Type>,
        @EnvironmentEffectBuilder
        _ transform: @Sendable @escaping (EmptyEnvironmentEffect, any Theme) -> EmptyEnvironmentEffect
    ) -> some InlineContent {
        let config = ThemeEnvironmentEffectConfiguration.expandedConfiguration(from: transform)
        BuildContext.register(config.scopedStyle)
        return self.class(config.scopedStyle.allClasses)
    }

    /// Produces styles that respond to a boolean environment condition.
    /// - Parameters:
    ///   - keyPath: A key path selecting a boolean environment condition.
    ///   - transform: A closure that produces styles for the boolean condition.
    /// - Returns: A modified HTML node with a generated CSS class attached
    ///   when styles are produced.
    func environmentEffect(
        _ keyPath: KeyPath<BooleanEnvironmentEffectValues, BooleanEnvironmentKey>,
        @EnvironmentEffectBuilder
        _ transform: @Sendable @escaping (EmptyEnvironmentEffect, Bool) -> EmptyEnvironmentEffect
    ) -> some InlineContent {
        let config = BooleanEnvironmentEffectConfiguration.expandedConfiguration(keyPath: keyPath, from: transform)
        BuildContext.register(config.scopedStyle)
        return self.class(config.scopedStyle.allClasses)
    }

    /// Produces styles that vary across values of an attribute-backed environment.
    /// - Parameters:
    ///   - keyPath: A key path selecting the attribute-backed environment dimension.
    ///   - transform: Produces styles for a specific attribute value.
    /// - Returns: Modified inline content with generated environment styles applied.
    func environmentEffect<V: AttributeEnvironmentEffectValue>(
        _ keyPath: KeyPath<AttributeEnvironmentEffectValues, V.Type>,
        @EnvironmentEffectBuilder
        _ transform: @Sendable @escaping (EmptyEnvironmentEffect, V) -> EmptyEnvironmentEffect
    ) -> some InlineContent {
        let config = AttributeEnvironmentEffectConfiguration
            .expandedConfiguration(for: V.self, from: transform)

        BuildContext.register(config.scopedStyle)
        return self.class(config.scopedStyle.allClasses)
    }
}
