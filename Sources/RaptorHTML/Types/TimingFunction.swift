//
// TimingFunction.swift
// RaptorHTML
// https://raptor.build
// See LICENSE for license information.
//

/// Represents a CSS [`timing-function`](https://developer.mozilla.org/en-US/docs/Web/CSS/timing-function) value,
/// which defines how intermediate values of a transition or animation are calculated.
///
/// Supports all predefined CSS timing keywords (`ease`, `linear`, etc.), the full extended easing set
/// from the CSS Easing specification (`ease-in-sine`, `ease-out-back`, etc.), cubic-bezier curves,
/// and function-based easing such as `steps()` and `frames()`.
public struct TimingFunction: Hashable, Equatable, Sendable, CustomStringConvertible {
    /// The raw CSS value for this timing function (e.g. `"ease-in-out"`, `"cubic-bezier(...)"`).
    let css: String

    /// Creates a new timing function from a CSS string value.
    /// - Parameter css: A valid CSS timing function expression.
    package init(_ css: String) {
        self.css = css
    }

    /// A gradual acceleration followed by a gradual deceleration.
    public static let ease = Self("ease")

    /// A constant speed from start to end.
    public static let linear = Self("linear")

    /// Starts slowly and accelerates to full speed.
    public static let easeIn = Self("ease-in")

    /// Starts quickly and decelerates to a stop.
    public static let easeOut = Self("ease-out")

    /// Starts and ends slowly, accelerating in the middle.
    public static let easeInOut = Self("ease-in-out")

    /// Starts gently, following a sine curve.
    public static let easeInSine = Self("ease-in-sine")

    /// Ends gently, following a sine curve.
    public static let easeOutSine = Self("ease-out-sine")

    /// Starts and ends gently with a sine curve.
    public static let easeInOutSine = Self("ease-in-out-sine")

    /// Starts slowly, accelerating quadratically.
    public static let easeInQuadratic = Self("ease-in-quad")

    /// Decelerates quadratically toward the end.
    public static let easeOutQuadratic = Self("ease-out-quad")

    /// Starts and ends smoothly with quadratic acceleration.
    public static let easeInOutQuadratic = Self("ease-in-out-quad")

    /// Starts slowly, accelerating cubically.
    public static let easeInCubic = Self("ease-in-cubic")

    /// Decelerates cubically toward the end.
    public static let easeOutCubic = Self("ease-out-cubic")

    /// Starts and ends smoothly with cubic acceleration.
    public static let easeInOutCubic = Self("ease-in-out-cubic")

    /// Starts slowly, accelerating quartically.
    public static let easeInQuartic = Self("ease-in-quart")

    /// Decelerates quartically toward the end.
    public static let easeOutQuartic = Self("ease-out-quart")

    /// Starts and ends smoothly with quartic acceleration.
    public static let easeInOutQuartic = Self("ease-in-out-quart")

    /// Starts slowly, accelerating quintically.
    public static let easeInQuintic = Self("ease-in-quint")

    /// Decelerates quintically toward the end.
    public static let easeOutQuintic = Self("ease-out-quint")

    /// Starts and ends smoothly with quintic acceleration.
    public static let easeInOutQuintic = Self("ease-in-out-quint")

    /// Starts slowly, then speeds up exponentially.
    public static let easeInExponential = Self("ease-in-expo")

    /// Starts quickly, then slows down exponentially.
    public static let easeOutExponential = Self("ease-out-expo")

    /// Starts and ends exponentially, with a fast middle.
    public static let easeInOutExponential = Self("ease-in-out-expo")

    /// Starts slowly, following a circular path.
    public static let easeInCircular = Self("ease-in-circ")

    /// Ends slowly, following a circular path.
    public static let easeOutCircular = Self("ease-out-circ")

    /// Starts and ends slowly, following a circular path.
    public static let easeInOutCircular = Self("ease-in-out-circ")

    /// Starts by moving backward slightly, then accelerates.
    public static let easeInBack = Self("ease-in-back")

    /// Overshoots the end, then settles back.
    public static let easeOutBack = Self("ease-out-back")

    /// Overshoots both the start and end slightly.
    public static let easeInOutBack = Self("ease-in-out-back")

    /// Starts slowly, stretching like an elastic band.
    public static let easeInElastic = Self("ease-in-elastic")

    /// Ends with an elastic bounce.
    public static let easeOutElastic = Self("ease-out-elastic")

    /// Starts and ends with an elastic bounce.
    public static let easeInOutElastic = Self("ease-in-out-elastic")

    /// Starts with a bounce effect.
    public static let easeInBounce = Self("ease-in-bounce")

    /// Ends with a bounce effect.
    public static let easeOutBounce = Self("ease-out-bounce")

    /// Starts and ends with a bounce effect.
    public static let easeInOutBounce = Self("ease-in-out-bounce")

    /// A cubic Bézier timing curve defined by four control points.
    /// - Parameters:
    ///   - x1: The x-coordinate of the first control point (0–1).
    ///   - y1: The y-coordinate of the first control point (0–1).
    ///   - x2: The x-coordinate of the second control point (0–1).
    ///   - y2: The y-coordinate of the second control point (0–1).
    public static func cubicBezier(x1: Double, y1: Double, x2: Double, y2: Double) -> Self {
        Self("cubic-bezier(\(x1), \(y1), \(x2), \(y2))")
    }

    /// A stepped timing function, dividing the animation into discrete steps.
    /// - Parameters:
    ///   - count: The number of steps.
    ///   - position: The point in the cycle where the jump occurs (`start` or `end`).
    public static func steps(count: Int, position: StepPosition = .end) -> Self {
        Self("steps(\(count), \(position.rawValue))")
    }

    /// A frame-based easing function (CSS `frames()`).
    /// - Parameter count: The number of animation frames.
    public static func frames(count: Int) -> Self {
        Self("frames(\(count))")
    }

    /// Defines when a `steps()` timing function jumps between steps.
    public enum StepPosition: String, Hashable, Equatable, Sendable {
        case start, end
    }

    public var description: String { css }
}
