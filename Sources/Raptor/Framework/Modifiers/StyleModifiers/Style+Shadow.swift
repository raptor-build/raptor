//
// Style+Shadow.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

public extension Stylable {
    /// Applies an inner shadow to this element.
    /// - Parameters:
    ///   - color: The shadow's color. Defaults to black at 33% opacity.
    ///   - radius: The shadow's radius
    ///   - x: The X offset for the shadow, specified in pixels. Defaults to 0.
    ///   - y: The Y offset for the shadow, specified in pixels. Defaults to 0.
    /// - Returns: A copy of this element with the updated shadow applied.
    func innerShadow(_ color: Color = .black.opacity(0.33), radius: Int, x: Int = 0, y: Int = 0) -> Self {
        let shadow = Shadow(color: color, radius: radius, x: x, y: y, inset: true)
        return self.style(.boxShadow(shadow))
    }

    /// Applies a drop shadow to this element.
    /// - Parameters:
    ///   - color: The shadow's color. Defaults to black at 33% opacity.
    ///   - radius: The shadow's radius
    ///   - x: The X offset for the shadow, specified in pixels. Defaults to 0.
    ///   - y: The Y offset for the shadow, specified in pixels. Defaults to 0.
    /// - Returns: A copy of this element with the updated shadow applied.
    func shadow(_ color: Color = .black.opacity(0.33), radius: Int, x: Int = 0, y: Int = 0) -> Self {
        let shadow = Shadow(color: color, radius: radius, x: x, y: y, inset: false)
        return self.style(.boxShadow(shadow))
    }
}
