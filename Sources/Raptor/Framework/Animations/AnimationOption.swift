//
// AnimationOption.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

/// Defines configurable options for an animation, including timing, direction, and lifecycle behavior.
public enum AnimationOption: Hashable, Sendable {
    /// How many times the animation repeats.
    case repeatCount(Double)

    /// Defines how the animation behaves before it begins and after it ends.
    case lifecycle(AnimationLifecycle)

    /// Controls whether the animation plays forwards, backwards, or alternates.
    case direction(AnimationDirection)

    /// The duration of the animation, in seconds.
    case duration(Double)

    /// The timing function that defines acceleration and easing.
    case timingCurve(TimingCurve)

    /// The delay before the animation begins, in seconds.
    case delay(Double)

    /// Adjusts playback speed by scaling the duration.
    case speed(Double)

    /// Default configuration for a smooth, single-run ease-in-out animation.
    public static var defaultOptions: [Self] {
        [
            .duration(1),
            .timingCurve(.easeInOut),
            .lifecycle(.automatic),
            .repeatCount(1)
        ]
    }
}
