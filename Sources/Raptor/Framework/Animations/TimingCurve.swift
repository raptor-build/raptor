//
// TimingCurve.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

/// Defines the available timing functions for CSS animations and transitions.
public struct TimingCurve: Sendable, Hashable, Equatable {
    /// The CSS timing function string (e.g. `"ease-in-out"`, `"cubic-bezier(...)"`).
    let curve: String

    /// The base duration in seconds (used for convenience in animations).
    let baseDuration: Double

    private init(css: String, baseDuration: Double = 0.2) {
        self.curve = css
        self.baseDuration = baseDuration
    }

    public static let automatic = TimingCurve(css: "cubic-bezier(0.4, 1.0, 0.0, 1.0)", baseDuration: 0.2)
    public static let linear = TimingCurve(css: "linear")
    public static let easeIn = TimingCurve(css: "ease-in")
    public static let easeOut = TimingCurve(css: "ease-out")
    public static let easeInOut = TimingCurve(css: "ease-in-out")

    public static let smooth = TimingCurve(css: "cubic-bezier(0.4, 1.0, 0.0, 1.0)", baseDuration: 0.3)
    public static let snappy = TimingCurve(css: "cubic-bezier(0.4, 0.85, 0.15, 1.0)", baseDuration: 0.15)
    public static let bouncy = TimingCurve(css: "cubic-bezier(0.4, 0.7, 0.3, 1.0)", baseDuration: 0.4)

    public static func spring(dampingRatio: Double, velocity: Double) -> Self {
        .init(css: "cubic-bezier(0.4, \(dampingRatio), \(velocity), 1.0)")
    }

    public static func bezier(x1: Double, y1: Double, x2: Double, y2: Double) -> Self {
        .init(css: "cubic-bezier(\(x1), \(y1), \(x2), \(y2))")
    }

    public static func custom(_ value: String) -> Self {
        .init(css: value)
    }

    public func speed(_ factor: Double) -> Self {
        .init(css: curve, baseDuration: baseDuration / factor)
    }

    public func duration(_ seconds: Double) -> Self {
        .init(css: curve, baseDuration: seconds)
    }

    public func duration(_ milliseconds: Int) -> Self {
        .init(css: curve, baseDuration: Double(milliseconds) / 1000.0)
    }
}

public extension TimingCurve {
    static func smooth(duration: Double = 0.3, extraBounce: Double = 0.0) -> Self {
        let damping = 1.0 - extraBounce
        return .spring(dampingRatio: damping, velocity: extraBounce).duration(duration)
    }

    static func snappy(duration: Double = 0.15, extraBounce: Double = 0.0) -> Self {
        let damping = 0.85 - extraBounce
        return .spring(dampingRatio: damping, velocity: 0.15 + extraBounce).duration(duration)
    }

    static func bouncy(duration: Double = 0.4, extraBounce: Double = 0.0) -> Self {
        let damping = 0.7 - extraBounce
        return .spring(dampingRatio: damping, velocity: 0.3 + extraBounce).duration(duration)
    }
}

extension TimingCurve {
    /// Converts this `TimingCurve` into its corresponding `RaptorHTML.TimingFunction`.
    var html: TimingFunction {
        .init(curve)
    }
}
