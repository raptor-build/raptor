//
// AnimationDirection.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

/// Describes the direction in which an animation plays.
public struct AnimationDirection: Hashable, Sendable {
    private enum Base: String {
        case forward = "normal"
        case backward = "reverse"
    }

    private let base: Base
    private let isReversing: Bool

    private init(_ base: Base, reversing: Bool = false) {
        self.base = base
        self.isReversing = reversing
    }

    /// The animation plays forward from start to end.
    public static let forward = Self(.forward)

    /// The animation plays backward from end to start.
    public static let backward = Self(.backward)

    /// The resolved CSS keyword for this direction.
    /// - Returns: One of `normal`, `reverse`, `alternate`, or `alternate-reverse`.
    var rawValue: String {
        switch (base, isReversing) {
        case (.forward, false): "normal"
        case (.backward, false): "reverse"
        case (.forward, true): "alternate"
        case (.backward, true): "alternate-reverse"
        }
    }

    /// Returns a variant of this direction that alternates direction
    /// each cycle of the animation.
    public func reversing() -> Self {
        isReversing ? self : .init(base, reversing: true)
    }

    /// Maps this instance to its corresponding CSS animation direction value.
    var cssProperty: RaptorHTML.AnimationDirection {
        switch (base, isReversing) {
        case (.forward, false): .automatic
        case (.backward, false): .reverse
        case (.forward, true): .alternate
        case (.backward, true): .alternateReverse
        }
    }

}
