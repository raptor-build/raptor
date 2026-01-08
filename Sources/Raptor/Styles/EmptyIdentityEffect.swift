//
// EmptyIdentityEffect.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

/// An effect that applies styles when a specific identity trait is present.
public struct EmptyIdentityEffect<Trait: IdentityTrait>: Stylable {
    /// Inline style properties applied when the identity is active.
    private var styles = [Property]()

    /// Returns a new effect by adding a style property and value.
    /// - Parameter style: The style property to apply.
    /// - Returns: A modified identity effect including the provided style.
    public func style(_ style: Property) -> Self {
        var copy = self
        copy.styles.append(style)
        return copy
    }

    /// Resolves the effect into a scoped style activated by the identity trait.
    var scopedStyle: ScopedStyle {
        let baseClass = "identity-" + id
        let attributeName = Trait.attributeName

        let selector = Selector
            .class(baseClass)
            .with(.booleanAttribute(attributeName))

        return ScopedStyle(
            baseClass: baseClass,
            variants: [
                ScopedStyleVariant(
                    selector: selector,
                    styleProperties: OrderedSet(styles)
                )
            ]
        )
    }
}

extension EmptyIdentityEffect: ScopedStyleRepresentable {}
