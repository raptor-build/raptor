//
// HoverEffectModifier.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

public extension HTML {
    /// Applies a hover effect to this element.
    ///
    /// Example:
    /// ```swift
    /// Text("Hover me")
    ///     .hoverEffect { content in
    ///         content
    ///             .background(.blue)
    ///             .foregroundStyle(.white)
    ///     }
    /// ```
    ///
    /// - Parameter effect: A closure that builds a `HoverConfiguration` describing
    ///   the hover styles.
    /// - Returns: A modified HTML element with the generated hover class applied.
    func hoverEffect(_ effect: (EmptyHoverEffect) -> EmptyHoverEffect) -> some HTML {
        let resolvedEffect = effect(.init())
        BuildContext.register(resolvedEffect.scopedStyle)
        return self.class(resolvedEffect.scopedStyle.allClasses)
    }

    /// Applies a hover effect to this element.
    /// - Parameters:
    ///   - anchor:The transform anchor for the effect.
    ///   - effect: A closure that builds a `HoverConfiguration` describing
    ///   the hover styles.
    /// - Returns: A modified HTML element with the generated hover class applied.
    func hoverEffect(anchor: UnitPoint, _ effect: (EmptyHoverEffect) -> EmptyHoverEffect) -> some HTML {
        let resolvedEffect = effect(.init(anchor: anchor))
        BuildContext.register(resolvedEffect.scopedStyle)
        return self.class(resolvedEffect.scopedStyle.allClasses)
    }
}

public extension InlineContent {
    /// Applies a hover effect to this element.
    /// - Parameter effect: A closure that builds a `HoverConfiguration` describing
    ///   the hover styles.
    /// - Returns: A modified HTML element with the generated hover class applied.
    func hoverEffect(_ effect: (EmptyHoverEffect) -> EmptyHoverEffect) -> some InlineContent {
        let resolvedEffect = effect(.init())
        BuildContext.register(resolvedEffect.scopedStyle)
        return self.class(resolvedEffect.scopedStyle.allClasses)
    }

    /// Applies a hover effect to this element.
    /// - Parameters:
    ///   - anchor:The transform anchor for the effect.
    ///   - effect: A closure that builds a `HoverConfiguration` describing
    ///   the hover styles.
    /// - Returns: A modified HTML element with the generated hover class applied.
    func hoverEffect(
        anchor: UnitPoint,
        _ effect: (EmptyHoverEffect
        ) -> EmptyHoverEffect) -> some InlineContent {
        let resolvedEffect = effect(.init(anchor: anchor))
        BuildContext.register(resolvedEffect.scopedStyle)
        return self.class(resolvedEffect.scopedStyle.allClasses)
    }
}
