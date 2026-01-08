//
// LightTheme.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

extension Theme where Self == DefaultTheme {
    /// Creates a default light theme instance.
    static var `default`: some Theme { DefaultTheme() }
}

/// The default light theme implementation.
/// This theme provides all standard light mode colors and styling without any customization.
struct DefaultTheme: Theme {
    func theme(site: Content, colorScheme: ColorScheme) -> Content {
        site.syntaxHighlighterTheme(.xcode)
    }
}
