//
// AnimationLifecycle.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

/// Describes how an element’s styles are applied before and after an animation runs.
public enum AnimationLifecycle: String, Sendable, Hashable, Equatable {
    /// The animation applies its initial keyframe before
    /// playback and retains its final keyframe afterward.
    case automatic

    /// The animation applies its initial keyframe before
    /// playback but restores the original state when finished.
    case transient

    /// The animation plays independently, without preapplying
    /// or preserving any keyframe styles.
    case isolated

    /// Maps each lifecycle to the corresponding CSS `animation-fill-mode` value.
    var fillMode: RaptorHTML.FillMode {
        switch self {
        case .automatic: .both
        case .transient: .backwards
        case .isolated: .none
        }
    }

    /// Indicates whether the lifecycle preapplies the first frame visually before animation starts.
    var preappliesFirstFrame: Bool {
        self != .isolated
    }
}
