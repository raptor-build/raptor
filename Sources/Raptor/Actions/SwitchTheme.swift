//
// SwitchTheme.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

/// An action that switches between themes.
public struct SwitchTheme: Action {
    /// The ID of the theme to switch to.
    private let themeID: String

    /// Creates a new theme switching action
    /// - Parameter theme: The ID of the theme to switch to
    public init(_ theme: any Theme) {
        self.themeID = theme.cssID
    }

    /// Compiles the action into JavaScript code that calls the switchTheme function
    /// - Returns: JavaScript code to execute the theme switch
    public func compile() -> String {
        "setTheme('\(themeID)');"
    }
}

public extension Action where Self == SwitchTheme {
    /// Creates a new `SwitchTheme` action
    /// - Parameter theme: The theme to switch to
    /// - Returns: A `SwitchTheme` action configured with the specified theme
    static func switchTheme(_ theme: any Theme) -> Self {
        SwitchTheme(theme)
    }
}
