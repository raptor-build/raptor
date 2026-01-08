//
// AnimationPlayState.swift
// RaptorHTML
// https://raptor.build
// See LICENSE for license information.
//

/// Specifies whether an animation is currently running or paused.
public enum AnimationPlayState: String, Sendable, CustomStringConvertible {
    /// The animation is currently playing.
    case running
    /// The animation is paused.
    case paused

    public var description: String { rawValue }
    public var css: String { rawValue }
}
