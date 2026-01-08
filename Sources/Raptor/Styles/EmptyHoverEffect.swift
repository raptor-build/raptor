//
// HoverConfiguration.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

/// A configuration that defines visual styles applied when a user hovers over an element.
///
/// This type is used by the `.hoverEffect(_:)` modifier to describe how an element should
/// look in its hovered state. Internally, the configuration is registered with the
/// `StyleManager`, which generates a CSS class with `:hover` rules.
public struct EmptyHoverEffect: Sendable, Hashable, Stylable {
    /// The collection of inline styles applied in the hovered state.
    private var styles: [Property] {
        var result = resolvedStyles
        if let transform = resolvedTransform {
            result.append(transform)
        }
        return result
    }

    /// Stored non-transform style properties applied in the hovered state.
    private var resolvedStyles: [Property] = [
        .transition(.custom("all var(--anim-duration, 0.3s) var(--anim-easing, cubic-bezier(0.25, 0.46, 0.45, 0.94))"))
    ]

    /// Stored transform components (scale, rotation, translation).
    private var transformComponents: [TransformComponent] = []

    /// Resolves stored transform components into a single transform property.
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

    /// Creates a new hover effect with a specified transform anchor.
    init(anchor: UnitPoint) {
        setTransformAnchor(anchor)
    }

    /// Creates a new empty hover effect with default settings.
    init() {}

    /// Sets the transform anchor for all applied transforms.
    /// - Parameter anchor: The reference point used for scaling and rotation.
    private mutating func setTransformAnchor(_ anchor: UnitPoint) {
        resolvedStyles.append(.transformOrigin(.init(x: anchor.xPercentValue, y: anchor.yPercentValue)))
    }

    /// Returns a new configuration by adding a style property and value.
    /// - Parameter style: The style property to apply when the element is hovered.
    /// - Returns: A modified hover configuration including the provided style.
    public func style(_ style: Property) -> Self {
        var copy = self
        copy.resolvedStyles.append(style)
        return copy
    }
}

extension EmptyHoverEffect: ScopedStyleRepresentable {
    /// An effect configuration and produces a variant that applies its selector.
    var scopedStyle: ScopedStyle {
        let baseClass = "hover-" + String(describing: self).truncatedHash
        let variant = ScopedStyleVariant(
            selector: .class(baseClass).with(.hover),
            styleProperties: OrderedSet(styles)
        )

        var variants = [ScopedStyleVariant]()
        variants.append(variant)
        return ScopedStyle(baseClass: baseClass, variants: variants)
    }
}

public extension EmptyHoverEffect {
    /// Applies a scaling transform when the element is hovered.
    /// - Parameters:
    ///   - value: The uniform scale factor (e.g. `1.1` for a subtle zoom).
    func scaleEffect(_ value: Double) -> Self {
        var copy = self
        copy.transformComponents.append(.scale(x: value, y: value))
        return copy
    }

    /// Rotates the element by the specified angle when hovered.
    /// - Parameters:
    ///   - angle: The rotation angle in degrees (e.g. `15` for 15° clockwise).
    /// - Returns: A modified hover configuration with the rotation effect applied.
    func rotationEffect(_ angle: Double) -> Self {
        var copy = self
        copy.transformComponents.append(.rotate(angle))
        return copy
    }

    /// Translates the element when hovered.
    /// - Parameters:
    ///   - x: The horizontal offset in pixels.
    ///   - y: The vertical offset in pixels.
    func offset(x: Double = 0, y: Double = 0) -> Self {
        var copy = self
        copy.transformComponents.append(.translate(x: x, y: y))
        return copy
    }

    /// Applies a blur filter to the element when hovered.
    /// - Parameter radius: The blur radius in pixels.
    /// - Returns: A modified hover configuration with the blur effect.
    func blur(_ radius: Double) -> Self {
        var copy = self
        copy.resolvedStyles.append(.filter(.blur(.px(radius))))
        return copy
    }

    /// Adjusts brightness of the element when hovered.
    /// - Parameter amount: The brightness multiplier (1.0 = unchanged, 1.5 = 150% brighter).
    /// - Returns: A modified hover configuration with the brightness effect.
    func brightness(_ amount: Double) -> Self {
        var copy = self
        copy.resolvedStyles.append(.filter(.brightness(amount)))
        return copy
    }

    /// Adjusts saturation of the element when hovered.
    /// - Parameter amount: The saturation multiplier (1.0 = unchanged, 0 = grayscale).
    /// - Returns: A modified hover configuration with the saturation effect.
    func saturation(_ amount: Double) -> Self {
        var copy = self
        copy.resolvedStyles.append(.filter(.saturate(amount)))
        return copy
    }

    /// Converts the element to grayscale when hovered.
    /// - Parameter amount: The grayscale amount (`0.0` = normal, `1.0` = fully grayscale).
    /// - Returns: A modified hover configuration with the grayscale effect.
    func grayscale(_ amount: Double = 1.0) -> Self {
        var copy = self
        copy.resolvedStyles.append(.filter(.grayscale(amount)))
        return copy
    }
}
