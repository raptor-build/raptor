//
// PreferredColorSchemeModifier.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

public extension HTML {
    /// A modifier that sets the preferred color scheme for a container element.
    /// - Parameter colorScheme: The preferred color scheme to use. If `nil`, no color scheme is enforced.
    /// - Returns: A modified HTML element with the specified color scheme.
    func preferredColorScheme(_ colorScheme: SystemColorScheme) -> some HTML {
        self.data("color-scheme", colorScheme.rawValue)
    }
}

public extension InlineContent {
    /// A modifier that sets the preferred color scheme for a container element.
    /// - Parameter colorScheme: The preferred color scheme to use. If `nil`, no color scheme is enforced.
    /// - Returns: A modified HTML element with the specified color scheme.
    func preferredColorScheme(_ colorScheme: SystemColorScheme) -> some InlineContent {
        self.data("color-scheme", colorScheme.rawValue)
    }
}
