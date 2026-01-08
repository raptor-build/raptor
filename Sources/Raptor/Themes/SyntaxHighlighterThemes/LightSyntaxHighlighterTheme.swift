//
// LightSyntaxHighlighterTheme.swift
// Raptor Build
// https://raptor.build
// See LICENSE for license information.
//

/// A syntax highlighter theme that always resolves using the light color scheme.
public struct LightSyntaxHighlighterTheme<Theme: SyntaxHighlighterTheme>: SyntaxHighlighterTheme {
    /// The underlying theme being wrapped.
    let baseTheme: Theme

    /// Resolves the wrapped theme using the light color scheme,
    /// ignoring the environment-provided scheme.
    public func theme(code: Content, colorScheme: ColorScheme) -> Content {
        baseTheme.theme(code: code, colorScheme: .light)
    }
}

public extension SyntaxHighlighterTheme {
    /// Returns a theme that always resolves using the light color scheme,
    /// regardless of the surrounding environment.
    func light() -> some SyntaxHighlighterTheme {
        LightSyntaxHighlighterTheme(baseTheme: self)
    }
}
