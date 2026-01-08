//
// Shadow.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

extension Shadow {
    init(color: Color, radius: Int, x: Int, y: Int, inset: Bool) {
        self.init(color: color.html, radius: .px(radius), x: .px(x), y: .px(y))
    }
}

public extension HTML {
    /// Applies an inner shadow to this element.
    /// - Parameters:
    ///   - color: The shadow's color. Defaults to black at 33% opacity.
    ///   - radius: The shadow's radius
    ///   - x: The X offset for the shadow, specified in pixels. Defaults to 0.
    ///   - y: The Y offset for the shadow, specified in pixels. Defaults to 0.
    /// - Returns: A copy of this element with the updated shadow applied.
    func innerShadow(_ color: Color = .black.opacity(0.33), radius: Int, x: Int = 0, y: Int = 0) -> some HTML {
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
    func shadow(_ color: Color = .black.opacity(0.33), radius: Int, x: Int = 0, y: Int = 0) -> some HTML {
        let shadow = Shadow(color: color, radius: radius, x: x, y: y, inset: false)
        return self.style(.boxShadow(shadow))
    }
}

public extension InlineContent {
    /// Applies an inner shadow to this element.
    /// - Parameters:
    ///   - color: The shadow's color. Defaults to black at 33% opacity.
    ///   - radius: The shadow's radius
    ///   - x: The X offset for the shadow, specified in pixels. Defaults to 0.
    ///   - y: The Y offset for the shadow, specified in pixels. Defaults to 0.
    /// - Returns: A copy of this element with the updated shadow applied.
    func innerShadow(_ color: Color = .black.opacity(0.33), radius: Int, x: Int = 0, y: Int = 0) -> some InlineContent {
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
    func shadow(_ color: Color = .black.opacity(0.33), radius: Int, x: Int = 0, y: Int = 0) -> some InlineContent {
        let shadow = Shadow(color: color, radius: radius, x: x, y: y, inset: false)
        return self.style(.boxShadow(shadow))
    }
}
