//
// ButtonStyle.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

/// A protocol that defines a reusable, environment-aware visual style for buttons.
public protocol ButtonStyle: PhasedComponentStyle where Phase == ButtonPhase {
    /// A result builder used to declaratively compose button style definitions.
    typealias StyleBuilder = ButtonStyleBuilder

    /// The configuration type representing the button’s current state and styles.
    typealias Content = ButtonConfiguration
}

public extension InlineContent {
    /// Applies a custom `ButtonStyle` to the element and registers it for CSS generation.
    /// - Parameter style: The `ButtonStyle` to apply to the button.
    /// - Returns: A new `InlineElement` with the appropriate CSS class applied.
    func buttonStyle(_ style: some ButtonStyle) -> some InlineContent {
        BuildContext.register(style.resolved)
        return self.class(style.resolved.allClasses)
    }
}
