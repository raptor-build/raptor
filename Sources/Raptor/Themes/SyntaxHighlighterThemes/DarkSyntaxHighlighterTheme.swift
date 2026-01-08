//
// DarkSyntaxHighlighterTheme.swift
// Raptor Build
// https://raptor.build
// See LICENSE for license information.
//

/// A syntax highlighter theme that always resolves using the dark color scheme.
public struct DarkSyntaxHighlighterTheme<Theme: SyntaxHighlighterTheme>: SyntaxHighlighterTheme {
    /// The underlying theme being wrapped.
    let baseTheme: Theme

    /// Resolves the wrapped theme using the dark color scheme,
    /// ignoring the environment-provided scheme.
    public func theme(code: Content, colorScheme: ColorScheme) -> Content {
        baseTheme.theme(code: code, colorScheme: .dark)
    }
}

public extension SyntaxHighlighterTheme {
    /// Returns a theme that always resolves using the dark color scheme,
    /// regardless of the surrounding environment.
    func dark() -> some SyntaxHighlighterTheme {
        DarkSyntaxHighlighterTheme(baseTheme: self)
    }
}
