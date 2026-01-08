//
// TextShadow.swift
// RaptorHTML
// https://raptor.build
// See LICENSE for license information.
//

/// Defines one or more shadow effects applied to text.
///
/// Example:
/// ```swift
/// .textShadow(.single(x: .px(2), y: .px(2), blur: .px(4), color: .black))
/// ```
public struct TextShadow: Sendable, Hashable {
    let shadows: [Shadow]

    var css: String {
        shadows.map(\.css).joined(separator: ", ")
    }

    /// Creates a `TextShadow` from a single shadow definition.
    public static func single(color: Color? = nil, radius: LengthUnit? = nil, x: LengthUnit, y: LengthUnit) -> Self {
        .init([Shadow(color: color, radius: radius, x: x, y: y)])
    }

    /// Creates a `TextShadow` from multiple shadow layers.
    init(_ shadows: [Shadow]) {
        self.shadows = shadows
    }
}
