//
// EntryEffectModifier.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

public extension HTML {
    /// Applies an animation when the element becomes visible on screen.
    ///
    /// Example:
    /// ```swift
    /// Text("I'm visible!")
    ///     .entryEffect { content in
    ///         content
    ///             .opacity(1)
    ///     }
    /// ```
    ///
    /// - Parameter effect: A closure that configures and returns an `EmptyEntryEffect`.
    /// - Returns: An updated HTML element with the appropriate entry classes
    ///   and animation variables attached.
    func entryEffect(_ effect: (EmptyEntryEffect) -> EmptyEntryEffect) -> some HTML {
        let resolvedEffect = effect(.init())
        BuildContext.register(resolvedEffect.scopedStyle)
        let animatedProperties = resolvedEffect.animatedProperties.joined(separator: ",")
        return self
            .class("entry")
            .class(resolvedEffect.scopedStyle.allClasses)
            .data("anim-vars", animatedProperties)
    }

    /// Applies an animation when the element becomes visible on screen.
    /// - Parameters:
    ///   - anchor:The transform anchor for the effect.
    ///   - effect: A closure that configures and returns an `EmptyEntryEffect`.
    /// - Returns: An updated HTML element with the appropriate entry classes
    ///   and animation variables attached.
    func entryEffect(anchor: UnitPoint, _ effect: (EmptyEntryEffect) -> EmptyEntryEffect) -> some HTML {
        let resolvedEffect = effect(.init(anchor: anchor))
        BuildContext.register(resolvedEffect.scopedStyle)
        let animatedProperties = resolvedEffect.animatedProperties.joined(separator: ",")
        return self
            .class("entry")
            .class(resolvedEffect.scopedStyle.allClasses)
            .data("anim-vars", animatedProperties)
    }
}

public extension InlineContent {
    /// Applies an animation when the element becomes visible on screen.
    /// - Parameter effect: A closure that configures and returns an `EmptyEntryEffect`.
    /// - Returns: An updated HTML element with the appropriate entry classes
    ///   and animation variables attached.
    func entryEffect(_ effect: (EmptyEntryEffect) -> EmptyEntryEffect) -> some InlineContent {
        let resolvedEffect = effect(.init())
        BuildContext.register(resolvedEffect.scopedStyle)
        let animatedProperties = resolvedEffect.animatedProperties.joined(separator: ",")
        return self
            .class("entry")
            .class(resolvedEffect.scopedStyle.allClasses)
            .data("anim-vars", animatedProperties)
    }

    /// Applies an animation when the element becomes visible on screen.
    /// - Parameters:
    ///   - anchor:The transform anchor for the effect.
    ///   - effect: A closure that configures and returns an `EmptyEntryEffect`.
    /// - Returns: An updated HTML element with the appropriate entry classes
    ///   and animation variables attached.
    func entryEffect(anchor: UnitPoint, _ effect: (EmptyEntryEffect) -> EmptyEntryEffect) -> some InlineContent {
        let resolvedEffect = effect(.init(anchor: anchor))
        BuildContext.register(resolvedEffect.scopedStyle)
        let animatedProperties = resolvedEffect.animatedProperties.joined(separator: ",")
        return self
            .class("entry")
            .class(resolvedEffect.scopedStyle.allClasses)
            .data("anim-vars", animatedProperties)
    }
}
