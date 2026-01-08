//
// SwitchColorScheme.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

/// An action that switches between color schemes.
public struct SwitchColorScheme: Action {
    /// The color scheme used by the site.
    public typealias ColorScheme = UserColorScheme

    /// The color scheme to switch to.
    private let colorScheme: ColorScheme

    /// Creates a new theme switching action
    /// - Parameter theme: The ID of the theme to switch to (will be automatically sanitized)
    public init(_ colorScheme: ColorScheme) {
        self.colorScheme = colorScheme
    }

    /// Compiles the action into JavaScript code that calls the switchColorScheme function
    /// - Returns: JavaScript code to execute the theme switch
    public func compile() -> String {
        "setColorScheme('\(colorScheme.name)');"
    }
}

public extension Action where Self == SwitchColorScheme {
    /// The color scheme used by the site.
    typealias ColorScheme = UserColorScheme

    /// Creates a new `SwitchColorScheme` action
    /// - Parameter theme: The theme to switch to
    /// - Returns: A `SwitchColorScheme` action configured with the specified theme
    static func switchColorScheme(_ colorScheme: ColorScheme) -> Self {
        SwitchColorScheme(colorScheme)
    }
}
