//
// Theme.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

/// A protocol that defines the visual styling and layout properties for a website theme.
///
/// Themes provide comprehensive control over colors, typography, spacing, and responsive
/// breakpoints.
public protocol Theme: Sendable, Equatable {
    typealias Content = ThemeConfiguration
    typealias ColorScheme = ThemeColorScheme

    /// Resolves the style for the given HTML content and environment conditions
    /// - Parameters:
    ///   - content: An HTML element to apply styles to
    ///   - colorScheme: The current media query condition to resolve against
    /// - Returns: A modified HTML element with the appropriate styles applied
    @ThemeBuilder func theme(site: Content, colorScheme: ColorScheme) -> Content
}

public extension Theme {
    /// The type name, removing the word "Theme" if present
    var name: String {
        Self.baseName.titleCase()
    }
}

extension Theme {
    var resolved: ResolvedTheme {
        ResolvedTheme(self)
    }

    /// Generates CSS output for the given site color-scheme preference.
    /// - Parameter scheme: The site-wide color scheme (`.light`, `.dark`, or `.automatic`).
    /// - Returns: A complete CSS string representing all theme layers.
    func render(scheme: SiteColorScheme) async -> String {
        await ThemeGenerator(theme: self, colorScheme: scheme).generate()
    }

    /// A unique identifier derived from the type name.
    static var cssID: String {
        Self.baseName
            .kebabCased()
            .lowercased()
    }

    /// A unique identifier derived from the type name.
    var cssID: String {
        Self.cssID
    }
}

private extension Theme {
    static var baseName: String {
        let name = switch Self.self {
        case is DefaultTheme.Type: "default"
        default: String(describing: Self.self)
        }

        return name
    }
}
