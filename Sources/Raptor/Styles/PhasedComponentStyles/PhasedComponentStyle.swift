//
// PhasedComponentStyle.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

/// A protocol that defines a reusable, phase-based visual style for a component.
public protocol PhasedComponentStyle<Phase>: Sendable, Hashable {
    /// The phase type defining the component’s interaction states.
    associatedtype Phase: InteractionPhase

    /// A result builder used to declaratively compose the component’s style definitions.
    typealias StyleBuilder = PhasedComponentStyleBuilder<Phase>

    /// The configuration type representing the component’s current state and styles.
    typealias Content = PhasedComponentConfiguration<Phase>

    /// Defines the visual style for the component in a specific interaction phase.
    /// - Parameters:
    ///   - content: The current configuration of the component.
    ///   - phase: The interaction phase being styled.
    /// - Returns: A modified configuration containing the resolved phase styles.
    @StyleBuilder func style(content: Content, phase: Phase) -> Content
}

extension PhasedComponentStyle {
    /// A phased component style by generating a variant per interaction phase.
    var resolved: ScopedStyle {
        let prefix = String(describing: Self.self).kebabCased()
        let baseClass = "\(prefix)-\(String(describing: self).truncatedHash)"

        let variants = Phase.allCases.map { phase in
            var config = PhasedComponentConfiguration(phase: phase)
            config = style(content: config, phase: phase)

            let variant = ScopedStyleVariant(
                selector: phase.selector(from: .class(baseClass)),
                styleProperties: OrderedSet(config.styles),
                styles: config.styleClasses
            )

            return variant
        }

        return ScopedStyle(baseClass: baseClass, variants: variants)
    }
}
