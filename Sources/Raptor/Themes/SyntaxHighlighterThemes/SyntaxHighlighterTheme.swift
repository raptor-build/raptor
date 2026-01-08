//
// SyntaxHighlighterTheme.swift
// Raptor Build
// https://raptor.build
// See LICENSE for license information.
//

public protocol SyntaxHighlighterTheme: Sendable, Hashable {
    typealias Content = SyntaxHighlighterThemeConfiguration
    typealias ColorScheme = ThemeColorScheme

    /// Resolves the style for the given code and environment conditions
    /// - Parameters:
    ///   - content: The code to apply styling to
    ///   - colorScheme: The current media query condition to resolve against
    /// - Returns: The code with the appropriate styles applied
    @SyntaxHighlighterThemeBuilder func theme(code: Content, colorScheme: ColorScheme) -> Content
}

public extension SyntaxHighlighterTheme {
    /// Stable identifier derived from the concrete type name.
    ///
    /// Examples:
    /// - `GitHubDark` → `git-hub-dark`
    /// - `SolarizedLight` → `solarized-light`
    /// - `Okaidia` → `okaidia`
    var id: String {
        let typeName = String(describing: Self.self)
        return typeName.kebabCased()
    }
}

extension SyntaxHighlighterTheme {
    /// Returns this theme resolved into concrete configurations for all color schemes.
    var resolved: ResolvedSyntaxHighlighterTheme {
        ResolvedSyntaxHighlighterTheme(self)
    }
}
