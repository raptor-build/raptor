//
// LinkStyle.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

/// A protocol that defines a reusable, environment-aware visual style for links.
public protocol LinkStyle: PhasedComponentStyle where Phase == LinkPhase {
    /// A result builder used to declaratively compose link style definitions.
    typealias StyleBuilder = LinkStyleBuilder

    /// The configuration type representing the link’s current state and styles.
    typealias Content = LinkConfiguration
}

public extension InlineContent {
    /// Applies a custom `ButtonStyle` to the element and registers it for CSS generation.
    /// - Parameter style: The `ButtonStyle` to apply to the button.
    /// - Returns: A new `InlineElement` with the appropriate CSS class applied.
    func linkStyle(_ style: some LinkStyle) -> some InlineContent {
        BuildContext.register(style.resolved)
        return self.class(style.resolved.allClasses)
    }
}
