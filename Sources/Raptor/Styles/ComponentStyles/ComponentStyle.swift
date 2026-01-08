//
// ComponentStyle.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

/// A protocol that defines a reusable visual style for a specific UI component.
public protocol ComponentStyle: Hashable, Equatable, Sendable {
    /// The configuration representing the component’s current state and visual properties.
    typealias Content = ComponentConfiguration

    /// A result builder used to compose styles declaratively.
    typealias StyleBuilder = ComponentStyleBuilder

    /// Defines the component’s appearance for its current state.
    /// - Parameter content: The component configuration being styled.
    /// - Returns: A modified configuration containing the resolved visual properties.
    @StyleBuilder func style(content: Content) -> Content
}

extension ComponentStyle {
    /// A component style.
    var resolved: ScopedStyle {
        let prefix = String(describing: Self.self).kebabCased()
        let baseClass = "\(prefix)-\(String(describing: self).truncatedHash)"
        let config = style(content: .init())

        let baseVariant = ScopedStyleVariant(
            selector: .class(baseClass),
            styleProperties: OrderedSet(config.styles),
            styles: config.styleClasses)

        var variants = [ScopedStyleVariant]()
        variants.append(baseVariant)
        return ScopedStyle(baseClass: baseClass, variants: variants)
    }
}
