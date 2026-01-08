//
// IdentityEffectModifier.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

extension HTML {
    /// Applies an effect when the element has a specific identity trait.
    /// - Parameters:
    ///   - key: The identity trait key that activates this effect.
    ///   - transform: A closure that produces styles when the trait is present.
    /// - Returns: A modified HTML element.
    public func identityEffect<Trait: IdentityTrait>(
        _ trait: Trait.Type,
        _ transform: @Sendable @escaping (EmptyIdentityEffect<Trait>) -> EmptyIdentityEffect<Trait>
    ) -> some HTML {
        let resolvedEffect = transform(EmptyIdentityEffect<Trait>())
        BuildContext.register(resolvedEffect.scopedStyle)
        return self.class(resolvedEffect.scopedStyle.allClasses)
    }
}
