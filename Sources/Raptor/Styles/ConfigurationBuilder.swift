//
// ConfigurationBuilder.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

public typealias StyleBuilder = ConfigurationBuilder<StyleConfiguration>
public typealias ThemeBuilder = ConfigurationBuilder<ThemeConfiguration>
public typealias SyntaxHighlighterThemeBuilder = ConfigurationBuilder<SyntaxHighlighterThemeConfiguration>
public typealias ComponentStyleBuilder = ConfigurationBuilder<ComponentConfiguration>
public typealias MenuDropdownStyleBuilder = ComponentStyleBuilder

@resultBuilder
public enum ConfigurationBuilder<Configuration: Sendable>: Sendable {
    static var defaultValue: Configuration {
        fatalError("defaultValue must be overridden by specialization")
    }

    /// Builds a single configuration block.
    public static func buildBlock(_ components: Configuration) -> Configuration {
        components
    }

    /// Enables support for conditional `if` blocks.
    public static func buildOptional(_ component: Configuration?) -> Configuration {
        component ?? defaultValue
    }

    /// Enables support for `if/else` branching.
    public static func buildEither(first component: Configuration) -> Configuration {
        component
    }

    public static func buildEither(second component: Configuration) -> Configuration {
        component
    }

    /// Pass-through for empty expressions.
    public static func buildLimitedAvailability(_ component: Configuration) -> Configuration {
        component
    }
}

extension ConfigurationBuilder where Configuration == ThemeConfiguration {
    static var defaultValue: ThemeConfiguration {
        ThemeConfiguration()
    }
}

extension ConfigurationBuilder where Configuration == SyntaxHighlighterConfiguration {
    static var defaultValue: SyntaxHighlighterConfiguration {
        SyntaxHighlighterConfiguration()
    }
}

extension ConfigurationBuilder where Configuration == StyleConfiguration {
    static var defaultValue: StyleConfiguration {
        StyleConfiguration()
    }
}

extension ConfigurationBuilder where Configuration == ComponentConfiguration {
    static var defaultValue: ComponentConfiguration {
        ComponentConfiguration()
    }
}
