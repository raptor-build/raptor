//
// EmptyEntryEffect.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

/// A configuration that defines visual styles applied when an element first appears in view.
///
/// Used by `.appearEffect(_:)` to describe how an element should look as it enters
/// the viewport. Internally, the configuration is registered with `StyleManager`,
/// which generates a class that activates when the element becomes visible.
public struct EmptyEntryEffect: Sendable, Hashable, Stylable {
    /// Inline styles applied when the element appears.
    private var styles: [Property] {
        var result = resolvedStyles
        if let transform = resolvedTransform {
            result.append(transform)
        }
        return result
    }

    /// Attached custom style identifiers.
    private var styleClasses: [String] = []

    // Returns the CSS variable names this appear effect should control.
    var animatedProperties: [String] {
        styles.map(\.name)
    }

    /// Stored non-transform style properties applied on appearance.
    private var resolvedStyles: [Property] = [
        .transition(.custom("all var(--anim-duration, 0.3s) var(--anim-easing, cubic-bezier(0.25, 0.46, 0.45, 0.94))"))
    ]

    /// Stored transform components (scale, rotation, translation).
    private var transformComponents: [TransformComponent] = []

    /// Combines transform components into a single transform declaration.
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

    /// Creates a new entry effect with a specified transform anchor.
    init(anchor: UnitPoint) {
        setTransformAnchor(anchor)
    }

    /// Creates a new empty entry effect with default settings.
    init() {}

    /// Sets the transform anchor for any transforms that have been applied.
    /// - Parameter anchor: The reference point for scaling and rotation effects.
    /// - Returns: A modified configuration including the transform origin.
    private mutating func setTransformAnchor(_ anchor: UnitPoint) {
        resolvedStyles.append(.transformOrigin(.init(x: anchor.xPercentValue, y: anchor.yPercentValue)))
    }

    /// Returns a new configuration by adding a style property.
    /// - Parameter style: The appearance style to apply when the element becomes visible.
    /// - Returns: A modified configuration containing the new style.
    public func style(_ style: Property) -> Self {
        var copy = self
        copy.resolvedStyles.append(style)
        return copy
    }
}

extension EmptyEntryEffect: ScopedStyleRepresentable {
    /// An effect configuration and produces a variant that applies its selector.
    var scopedStyle: ScopedStyle {
        let baseClass = "entry-" + id
        let selector = Selector.class(baseClass).with(.class("visible"))
        let variant = ScopedStyleVariant(
            selector: .class(baseClass).with(selector),
            styleProperties: OrderedSet(styles),
            styles: styleClasses
        )

        var variants = [ScopedStyleVariant]()
        variants.append(variant)
        return ScopedStyle(baseClass: baseClass, variants: variants)
    }
}

public extension EmptyEntryEffect {
    /// Applies an opacity change when the element appears.
    /// - Parameter value: The target opacity value.
    /// - Returns: A modified configuration including the opacity change.
    func opacity(_ value: Double) -> Self {
        var copy = self
        copy.resolvedStyles.append(.opacity(value))
        return copy
    }

    /// Applies a positional translation when the element appears.
    /// - Parameters:
    ///   - x: The horizontal offset in pixels.
    ///   - y: The vertical offset in pixels.
    /// - Returns: A modified configuration including the translation.
    func offset(x: Double = 0, y: Double = 0) -> Self {
        var copy = self
        copy.transformComponents.append(.translate(x: x, y: y))
        return copy
    }

    /// Applies a scaling transform when the element appears.
    /// - Parameter value: The uniform scale factor.
    /// - Returns: A modified configuration including the scale transform.
    func scaleEffect(_ value: Double) -> Self {
        var copy = self
        copy.transformComponents.append(.scale(x: value, y: value))
        return copy
    }

    /// Applies a blur effect on appearance.
    /// - Parameter radius: The blur radius in pixels.
    /// - Returns: A modified configuration including the blur effect.
    func blur(_ radius: Double) -> Self {
        var copy = self
        copy.resolvedStyles.append(.filter(.blur(.px(radius))))
        return copy
    }
}
