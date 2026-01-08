//
// ScaleEffectModifier.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

/// A modifier that applies a scaling transform to an HTML element,
/// optionally anchored to a specific point.
private struct ScaleEffectModifier: HTMLModifier {
    /// The scale factors for the x and y axes.
    var scaleX: Double
    var scaleY: Double

    /// The anchor point of the scaling effect, from (0,0) to (1,1).
    var anchor: UnitPoint

    func body(content: Content) -> some HTML {
        var modified = content
        modified.attributes.append(styles: Self.styles(forX: scaleX, y: scaleY, anchor: anchor))
        return modified
    }

    /// Generates CSS variable–based scaling styles.
    /// Example output:
    /// ```css
    /// --r-scale-x: 1.2;
    /// --r-scale-y: 1.2;
    /// --r-scale-origin-x: 50%;
    /// --r-scale-origin-y: 50%;
    /// transform: scale(var(--r-scale-x), var(--r-scale-y));
    /// transform-origin: var(--r-scale-origin-x) var(--r-scale-origin-y);
    /// ```
    static func styles(forX x: Double, y: Double, anchor: UnitPoint) -> [Property] {
        // swiftlint:disable identifier_name
        let sx = String(format: "%.3f", x)
        let sy = String(format: "%.3f", y)
        let ox = String(format: "%.1f%%", anchor.x * 100)
        let oy = String(format: "%.1f%%", anchor.y * 100)

        return [
            .variable("r-scale-x", value: sx),
            .variable("r-scale-y", value: sy),
            .variable("r-scale-origin-x", value: ox),
            .variable("r-scale-origin-y", value: oy),
            .transform(.custom("scale(var(--r-scale-x), var(--r-scale-y))")),
            .custom("transform-origin", value: "var(--r-scale-origin-x) var(--r-scale-origin-y)")
        ]
        // swiftlint:enable identifier_name
    }
}

public extension HTML {
    /// Scales the element by independent x and y factors, optionally anchored to a point.
    /// - Parameters:
    ///   - x: Horizontal scaling factor.
    ///   - y: Vertical scaling factor.
    ///   - anchor: The point from which the scaling originates (default `.center`).
    func scaleEffect(x: Double, y: Double, anchor: UnitPoint = .center) -> some HTML {
        modifier(ScaleEffectModifier(scaleX: x, scaleY: y, anchor: anchor))
    }

    /// Uniform scaling shortcut (applies same factor to both axes).
    /// - Parameters:
    ///   - scale: The uniform scaling factor.
    ///   - anchor: The point from which the scaling originates (default `.center`).
    func scaleEffect(_ scale: Double, anchor: UnitPoint = .center) -> some HTML {
        modifier(ScaleEffectModifier(scaleX: scale, scaleY: scale, anchor: anchor))
    }
}
