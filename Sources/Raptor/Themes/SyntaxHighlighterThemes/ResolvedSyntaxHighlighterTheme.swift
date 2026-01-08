//
// ResolvedSyntaxHighlighterTheme.swift
// Raptor Build
// https://raptor.build
// See LICENSE for license information.
//

/// A fully-resolved set of syntax highlighter configurations for all color schemes.
struct ResolvedSyntaxHighlighterTheme: Sendable, Hashable {
    /// The configuration resolved using the `.any` color scheme.
    let base: SyntaxHighlighterThemeConfiguration

    /// The configuration resolved using the `.light` color scheme.
    let light: SyntaxHighlighterThemeConfiguration

    /// The configuration resolved using the `.dark` color scheme.
    let dark: SyntaxHighlighterThemeConfiguration

    /// Creates a resolved theme by evaluating the given theme for all color schemes.
    /// - Parameter theme: The syntax highlighter theme to resolve.
    init(_ theme: any SyntaxHighlighterTheme) {
        base = theme.theme(code: .init(), colorScheme: .any)
        light = theme.theme(code: .init(), colorScheme: .light)
        dark = theme.theme(code: .init(), colorScheme: .dark)
    }
}
