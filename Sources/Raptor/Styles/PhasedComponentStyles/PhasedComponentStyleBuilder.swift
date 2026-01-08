//
// PhasedComponentStyleBuilder.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

/// A result builder used to declaratively compose button styles
/// across different interaction phases (e.g. normal, hovered, pressed).
public typealias ButtonStyleBuilder = PhasedComponentStyleBuilder<ButtonPhase>

/// A result builder used to declaratively compose link styles
/// across different interaction phases (e.g. normal, hovered, visited).
public typealias LinkStyleBuilder = PhasedComponentStyleBuilder<LinkPhase>

/// A result builder used to declaratively compose disclosure label styles
/// across different interaction phases (e.g. collapsed, expanded, hovered).
public typealias DisclosureLabelStyleBuilder = PhasedComponentStyleBuilder<DisclosurePhase>

@resultBuilder
public enum PhasedComponentStyleBuilder<Phase: InteractionPhase>: Sendable {
    /// Builds a single configuration block.
    public static func buildBlock(
        _ components: PhasedComponentConfiguration<Phase>
    ) -> PhasedComponentConfiguration<Phase> {
        components
    }

    /// Enables support for conditional `if` blocks.
    public static func buildOptional(
        _ component: PhasedComponentConfiguration<Phase>?
    ) -> PhasedComponentConfiguration<Phase> {
        component ?? PhasedComponentConfiguration<Phase>()
    }

    /// Enables support for `if/else` branching.
    public static func buildEither(
        first component: PhasedComponentConfiguration<Phase>
    ) -> PhasedComponentConfiguration<Phase> {
        component
    }

    public static func buildEither(
        second component: PhasedComponentConfiguration<Phase>
    ) -> PhasedComponentConfiguration<Phase> {
        component
    }
}
