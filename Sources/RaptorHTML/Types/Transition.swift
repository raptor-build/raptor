//
// Transition.swift
// RaptorHTML
// https://raptor.build
// See LICENSE for license information.
//

/// Represents a CSS transition definition, combining property, duration, timing function, and delay.
///
/// Example:
/// ```swift
/// .transition(.init(property: .opacity, duration: .seconds(0.3), timing: .easeInOut))
/// ```
public struct Transition: Sendable, Hashable, CustomStringConvertible {
    /// The underlying CSS value.
    private let value: String

    /// A strongly typed transition component set.
    private let property: TransitionProperty?
    private let duration: Time?
    private let timing: TimingFunction?
    private let delay: Time?

    /// Creates a typed transition.
    public init(
        property: TransitionProperty = .all,
        duration: Time = .seconds(0.2),
        timing: TimingFunction = .easeInOut,
        delay: Time? = nil
    ) {
        self.property = property
        self.duration = duration
        self.timing = timing
        self.delay = delay

        var parts: [String] = [property.css, duration.css, timing.css]
        if let delay { parts.append(delay.css) }
        self.value = parts.joined(separator: " ")
    }

    /// Creates a raw custom transition string, for complex or variable-based expressions.
    ///
    /// Example:
    /// ```swift
    /// .transition(.custom("all var(--anim-duration, 0.3s) var(--anim-easing, cubic-bezier(...))"))
    /// ```
    public static func custom(_ css: String) -> Self {
        .init(rawValue: css)
    }

    /// Internal initializer used by `.custom`.
    private init(rawValue: String) {
        self.property = nil
        self.duration = nil
        self.timing = nil
        self.delay = nil
        self.value = rawValue
    }

    /// The CSS representation of this transition.
    var css: String { value }

    public var description: String { value }
}
