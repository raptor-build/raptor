//
// Keyframe.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

/// A proxy representing content at a specific point in an animation.
public typealias AnimatedContentProxy = Keyframe

/// A single frame within an animated sequence.
/// A keyframe describes the visual state at a given position in time.
/// Multiple keyframes are combined to form a complete animation.
public struct Keyframe: Sendable, Hashable {
    /// The location of this frame within the animation timeline,
    /// expressed as a percentage from `0%` to `100%`.
    var position: Percentage

    /// All resolved style properties that should be applied at this frame.
    /// This includes both explicitly stored properties and any
    /// combined transform effects.
    var styles: OrderedSet<Property> {
        var result = resolvedStyles
        if let transform = resolvedTransform {
            result.append(transform)
        }
        return result
    }

    /// Stored non-transform properties applied at this frame.
    private var resolvedStyles = OrderedSet<Property>()

    /// Stored transform components that will be merged into a single
    /// transform property when the frame is resolved.
    private var transformComponents: [TransformComponent] = []

    /// Creates a new keyframe at the specified timeline position.
    /// - Parameters:
    ///   - position: The point in the timeline where this frame occurs.
    ///   - data: Additional properties to apply at this frame.
    init(_ position: Percentage = 0%, data: OrderedSet<Property> = []) {
        self.position = position
        self.resolvedStyles = data
    }

    /// Produces a unified transform property derived from all transform components.
    /// Returns `nil` if no transform effects are present.
    private var resolvedTransform: Property? {
        guard !transformComponents.isEmpty else { return nil }

        let css = transformComponents.map { component -> String in
            switch component {
            case .scale(let x, let y):
                "scale(\(x), \(y))"
            case .translate(let x, let y):
                "translate(\(x)px, \(y)px)"
            case .rotate(let deg):
                "rotate(\(deg)deg)"
            }
        }
        .joined(separator: " ")

        return .transform(.custom(css))
    }
}

public extension Keyframe {
    /// Sets the background color at this keyframe.
    /// - Parameter color: The color value to apply.
    /// - Returns: A modified keyframe containing the new background style.
    func background(_ color: Color) -> Self {
        var copy = self
        copy.resolvedStyles.append(.backgroundColor(color.html))
        return copy
    }

    /// Sets the foreground color at this keyframe.
    /// - Parameter color: The color value to apply.
    /// - Returns: A modified keyframe containing the new foreground style.
    func foregroundStyle(_ color: Color) -> Self {
        var copy = self
        copy.resolvedStyles.append(.color(color.html))
        return copy
    }

    /// Applies a uniform scaling effect at this keyframe.
    /// - Parameter value: The scale factor to apply. A value of `1` preserves the current size.
    /// - Returns: A modified keyframe containing the new scaling instruction.
    func scaleEffect(_ value: Double) -> Self {
        var copy = self
        copy.transformComponents.append(.scale(x: value, y: value))
        return copy
    }

    /// Applies a rotational effect at this keyframe.
    /// - Parameter angle: The rotation angle, in degrees.
    /// - Returns: A modified keyframe containing the new rotation instruction.
    func rotationEffect(_ angle: Double) -> Self {
        var copy = self
        copy.transformComponents.append(.rotate(angle))
        return copy
    }

    /// Moves the content at this keyframe by the specified offset.
    /// - Parameters:
    ///   - x: The horizontal offset in points. Defaults to `0`.
    ///   - y: The vertical offset in points. Defaults to `0`.
    /// - Returns: A modified keyframe containing the new translation.
    func offset(x: Double = 0, y: Double = 0) -> Self {
        var copy = self
        copy.transformComponents.append(.translate(x: x, y: y))
        return copy
    }

    /// Adjusts the opacity of the content at this keyframe.
    /// - Parameter value: The opacity value, where `0` is fully transparent and `1` is fully opaque.
    /// - Returns: A modified keyframe containing the new opacity value.
    func opacity(_ value: Double) -> Self {
        var copy = self
        copy.resolvedStyles.append(.opacity(value))
        return copy
    }

    /// Specifies animation timing characteristics for this keyframe.
    /// - Parameter curve: The timing curve used to compute intermediate values.
    /// - Returns: A modified keyframe with updated timing characteristics.
    func animation(_ curve: TimingCurve) -> Self {
        var copy = self
        copy.resolvedStyles.append(.transitionDuration(.seconds(curve.baseDuration)))
        copy.resolvedStyles.append(.transitionTimingFunction(.init(curve.curve)))
        return copy
    }
}
