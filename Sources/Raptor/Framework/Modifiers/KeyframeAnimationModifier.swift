//
// KeyframeAnimationModifier.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

public extension HTML {
    /// Attaches a keyframe-based animation to this HTML element.
    /// - Parameters:
    ///   - trigger: The interaction that activates the animation, such as `.hover`, `.tap`, or `.entry`.
    ///   - options: Animation playback options including duration, timing curve, and iteration behavior.
    ///   Defaults to `.defaultOptions`.
    ///   - animation: A keyframe-building closure that returns the element’s visual state at a given timeline position.
    ///     This closure is invoked once for every percentage point in the animation timeline.
    /// - Returns: A modified HTML element with the generated animation classes applied.
    func keyframeAnimator(
        trigger: AnimationTrigger,
        options: [AnimationOption] = AnimationOption.defaultOptions,
        @KeyframeBuilder animation: (AnimatedContentProxy, Percentage) -> AnimatedContentProxy
    ) -> some HTML {
        let keyframes = buildKeyframes(animation: animation)
        let animation = registerAnimation(
            trigger: trigger,
            anchor: nil,
            options: options,
            keyframes: keyframes
        )
        return self.class(animation.classes)
    }

    /// Attaches a keyframe-based animation to this HTML element, using the specified transform anchor.
    /// - Parameters:
    ///   - trigger: The interaction that activates the animation.
    ///   - anchor: The transform anchor applied to the entire animation, expressed as a `UnitPoint`.
    ///   - options: Animation playback options such as duration and timing.
    ///   Defaults to `.defaultOptions`.
    ///   - animation: A keyframe-building closure evaluated for all timeline percentages from `0%` to `100%`.
    /// - Returns: A modified HTML element with the generated animation and anchor classes applied.
    func keyframeAnimator(
        trigger: AnimationTrigger,
        anchor: UnitPoint,
        options: [AnimationOption] = AnimationOption.defaultOptions,
        @KeyframeBuilder animation: (AnimatedContentProxy, Percentage) -> AnimatedContentProxy
    ) -> some HTML {
        let keyframes = buildKeyframes(animation: animation)
        let animation = registerAnimation(
            trigger: trigger,
            anchor: anchor,
            options: options,
            keyframes: keyframes
        )
        return self.class(animation.classes)
    }
}

public extension InlineContent {
    /// Attaches a keyframe-based animation to this HTML element.
    /// - Parameters:
    ///   - trigger: The interaction that activates the animation, such as `.hover`, `.tap`, or `.entry`.
    ///   - options: Animation playback options including duration, timing curve, and iteration behavior.
    ///   Defaults to `.defaultOptions`.
    ///   - animation: A keyframe-building closure that returns the element’s visual state at a given timeline position.
    ///     This closure is invoked once for every percentage point in the animation timeline.
    /// - Returns: A modified HTML element with the generated animation classes applied.
    func keyframeAnimator(
        trigger: AnimationTrigger,
        options: [AnimationOption] = AnimationOption.defaultOptions,
        @KeyframeBuilder animation: (AnimatedContentProxy, Percentage) -> AnimatedContentProxy
    ) -> some InlineContent {
        let keyframes = buildKeyframes(animation: animation)
        let animation = registerAnimation(
            trigger: trigger,
            anchor: nil,
            options: options,
            keyframes: keyframes
        )
        return self.class(animation.classes)
    }

    /// Attaches a keyframe-based animation to this HTML element, using the specified transform anchor.
    /// - Parameters:
    ///   - trigger: The interaction that activates the animation.
    ///   - anchor: The transform anchor applied to the entire animation, expressed as a `UnitPoint`.
    ///   - options: Animation playback options such as duration and timing.
    ///   Defaults to `.defaultOptions`.
    ///   - animation: A keyframe-building closure evaluated for all timeline percentages from `0%` to `100%`.
    /// - Returns: A modified HTML element with the generated animation and anchor classes applied.
    func keyframeAnimator(
        trigger: AnimationTrigger,
        anchor: UnitPoint,
        options: [AnimationOption] = AnimationOption.defaultOptions,
        @KeyframeBuilder animation: (AnimatedContentProxy, Percentage) -> AnimatedContentProxy
    ) -> some InlineContent {
        let keyframes = buildKeyframes(animation: animation)
        let animation = registerAnimation(
            trigger: trigger,
            anchor: anchor,
            options: options,
            keyframes: keyframes
        )
        return self.class(animation.classes)
    }
}

/// Builds a complete set of animation keyframes by evaluating a keyframe builder
/// closure for every percentage from 0% to 100%.
/// - Parameter animation: A closure that produces the visual state of the element
///   at a given animation percentage.
/// - Returns: An ordered array of resolved keyframes with their timeline positions set.
private func buildKeyframes(
    @KeyframeBuilder animation: (AnimatedContentProxy, Percentage) -> AnimatedContentProxy
) -> [AnimatedContentProxy] {
    (0...100).map { value in
        let percent = Percentage(value)
        var resolved = animation(.init(), percent)
        resolved.position = percent
        return resolved
    }
}

/// Registers a keyframe animation with the build context and returns the resulting animation object.
/// - Parameters:
///   - trigger: The interaction that activates the animation (e.g. hover, tap, or entry).
///   - anchor: An optional transform anchor applied to the animation.
///   - options: Playback options such as duration, timing curve, and repeat behavior.
///   - keyframes: The resolved keyframes that define the animation’s visual states.
/// - Returns: The registered `Animation` instance.
private func registerAnimation(
    trigger: AnimationTrigger,
    anchor: UnitPoint?,
    options: [AnimationOption],
    keyframes: [AnimatedContentProxy]
) -> Animation {
    let animation = Animation(trigger: trigger, anchor: anchor, options: options, keyframes: keyframes)
    BuildContext.register(animation)
    return animation
}
