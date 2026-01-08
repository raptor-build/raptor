//
// Animation.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

import OrderedCollections

/// A type that defines a multi-step animation using keyframes, configurable options, and an interaction trigger.
///
/// `Animation` represents a complete CSS keyframe animation composed of
/// multiple `Keyframe` objects (defining style states over time)
/// and a list of `AnimationOption` values that control playback behavior,
/// such as duration, delay, timing, or direction.
package struct Animation: Hashable, CSS {
    /// The collection of frames that define the animation sequence.
    var keyframes: [Keyframe]

    /// The configuration options that modify how the animation behaves.
    var options: [AnimationOption]

    /// The interaction that triggers the animation.
    var trigger: AnimationTrigger

    /// The transform origin of the animation.
    var anchor: UnitPoint?

    /// The unique animation name used in generated CSS, stable across builds.
    var name: String {
        "animation-\(trigger.rawValue)-\(String(describing: self).truncatedHash)"
    }

    /// All CSS classes that should be attached to the element.
    var classes: [String] { [name, trigger.cssClass].compactMap(\.self) }

    /// Creates an empty animation with no keyframes or options.
    init() {
        self.keyframes = []
        self.options = []
        self.trigger = .entry
    }

    /// Creates a new keyframe animation with the given options, keyframes, and trigger.
    /// This automatically normalizes keyframes by removing empty and duplicate entries.
    /// - Parameters:
    ///   - trigger: The interaction or state that activates the animation (e.g., `.hover`, `.tap`, `.entry`).
    ///   - anchor: The transform origin of the animation.
    ///   - options: An array of `AnimationOption` values that control playback and timing.
    ///   - keyframes: A list of `Keyframe` objects defining style transitions over time.
    init(
        trigger: AnimationTrigger = .entry,
        anchor: UnitPoint? = nil,
        options: [AnimationOption] = [],
        keyframes: [Keyframe] = []
    ) {
        self.trigger = trigger
        self.anchor = anchor
        self.options = options
        self.keyframes = Animation.normalizeKeyframes(keyframes)
    }

    /// Removes redundant or empty keyframes from a sequence.
    /// - Parameter keyframes: The original list of keyframes.
    /// - Returns: A normalized list containing only distinct, non-empty keyframes.
    private static func normalizeKeyframes(_ keyframes: [Keyframe]) -> [Keyframe] {
        keyframes
            .filter { !$0.styles.isEmpty }
            .reduce(into: [Keyframe]()) { result, frame in
                if let last = result.last, last.styles == frame.styles {
                    return
                }
                result.append(frame)
            }
    }

    /// Generates the complete CSS for an animation, including keyframes,
    /// trigger rules, and reverse-mode variants.
    /// - Returns: A complete CSS string containing all `@keyframes` definitions,
    ///   base class rules (if applicable), and trigger-based animation selectors.
    package func render() -> String {
        let baseSelector = Selector.class(name)
        let triggerSelector = selector(for: trigger, base: baseSelector)

        let (forwardKeyframes, reverseKeyframes) = generateKeyframesCSS()

        let properties: [Property] = OrderedSet(options).compactMap { option in
            switch option {
            case .repeatCount(let count): .animationIterationCount(count)
            case .direction(let direction): .animationDirection(direction.cssProperty)
            case .duration(let secs): .animationDuration(.seconds(secs))
            case .timingCurve(let curve): .animationTimingFunction(curve.html)
            case .delay(let secs): .animationDelay(.seconds(secs))
            case .speed(let multiplier): .animationDuration(.seconds(1.0 / multiplier))
            case .lifecycle(let lifecycle): .animationFillMode(lifecycle.fillMode)
            }
        }

        let ruleBody = properties
            .map(\.description)
            .joined(separator: "; ")

        let forwardRule = "\(triggerSelector) { animation-name: \(name)-forward; \(ruleBody) }"

        let reverseSelector = reverseSelector(for: trigger, base: baseSelector)
        let reverseRule = "\(reverseSelector) { animation-name: \(name)-reverse; \(ruleBody) }"

        let baseClassRule = preappliedFirstFrameRule()

        return [
            forwardKeyframes,
            reverseKeyframes,
            baseClassRule,
            forwardRule,
            reverseRule
        ]
        .filter { !$0.isEmpty }
        .joined(separator: "\n\n")
    }

    /// Builds both forward and reversed keyframe blocks for this animation.
    /// - Returns: A tuple containing the forward and reverse keyframe CSS blocks as strings.
    private func generateKeyframesCSS() -> (String, String) {
        let forwardFrames = keyframes.map { frame in
            let declarations = frame.styles.map(\.description).joined(separator: "; ")
            return "\(Int(frame.position.value))% { \(declarations) }"
        }.joined(separator: "\n")

        let forwardCSS = "@keyframes \(name)-forward {\n\(forwardFrames)\n}"

        let reversedFrames = keyframes.sorted { $0.position.value > $1.position.value }
        let reverseFramesCSS = reversedFrames.map { frame in
            let declarations = frame.styles.map(\.description).joined(separator: "; ")
            return "\(Int(100 - frame.position.value))% { \(declarations) }"
        }.joined(separator: "\n")

        let reverseCSS = "@keyframes \(name)-reverse {\n\(reverseFramesCSS)\n}"
        return (forwardCSS, reverseCSS)
    }

    /// Generates a static base rule if the lifecycle requires preapplying the first frame.
    /// - Returns: A CSS rule string for the base class, or an empty string if unused.
    private func preappliedFirstFrameRule() -> String {
        // Lifecycle `.automatic` or `.transient` both require the first frame to be visible before playback.
        let lifecycle = options.compactMap {
            if case let .lifecycle(mode) = $0 { mode } else { nil }
        }.first ?? .automatic

        guard lifecycle.preappliesFirstFrame, let firstFrame = keyframes.first else {
            return ""
        }

        var firstFrameStyles = firstFrame.styles

        if let anchor = anchor {
            firstFrameStyles.append(.transformOrigin(.init(x: anchor.xPercentValue, y: anchor.yPercentValue)))
        }

        let declarations = firstFrameStyles.map(\.description).joined(separator: "; ")
        return "\(Selector.class(name)) { \(declarations) }"
    }

    /// Resolves the base animation selector according to the animation’s trigger type.
    private func selector(for trigger: AnimationTrigger, base: Selector) -> Selector {
        switch trigger {
        case .hover: base.with(.hover)
        case .tap: base.with(.class("active"))
        case .entry: base.with(.class("in-view"))
        }
    }

    /// Builds the selector variant used when `.reverse-mode` is active.
    private func reverseSelector(for trigger: AnimationTrigger, base: Selector) -> Selector {
        if let triggerClass = trigger.cssClass {
            base.with(.class("reverse-mode")).with(.class(triggerClass))
        } else {
            base.with(.class("reverse-mode")).with(.hover)
        }
    }
}
