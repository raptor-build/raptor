//
// AnimationComposition.swift
// RaptorHTML
// https://raptor.build
// See LICENSE for license information.
//

/// Specifies how multiple animations with the same name are composed together.
///
/// Introduced in CSS Animations Level 2, this determines whether new animations
/// override or add to existing ones.
public enum AnimationComposition: String, Sendable, CustomStringConvertible {
    /// A new animation replaces an existing animation with the same name.
    case replace
    /// The animation adds to existing effects rather than replacing them.
    case add
    /// The animation automatically determines how to combine based on context.
    case accumulate

    public var description: String { rawValue }
    var css: String { rawValue }
}
