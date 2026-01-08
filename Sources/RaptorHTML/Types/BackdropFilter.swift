//
// BackdropFilter.swift
// RaptorHTML
// https://raptor.build
// See LICENSE for license information.
//

/// Represents visual effects applied to the area behind an element (e.g. blur, brightness).
public struct BackdropFilter: Sendable, Hashable {
    let css: String
    private init(_ css: String) { self.css = css }

    public static func blur(_ radius: LengthUnit) -> Self { .init("blur(\(radius.css))") }
    public static func brightness(_ amount: Double) -> Self { .init("brightness(\(amount))") }
    public static func contrast(_ amount: Double) -> Self { .init("contrast(\(amount))") }
    public static func grayscale(_ amount: Double) -> Self { .init("grayscale(\(amount))") }
    public static func hueRotate(_ angle: Angle) -> Self { .init("hue-rotate(\(angle.css))") }
    public static func invert(_ amount: Double) -> Self { .init("invert(\(amount))") }
    public static func opacity(_ amount: Double) -> Self { .init("opacity(\(amount))") }
    public static func saturate(_ amount: Double) -> Self { .init("saturate(\(amount))") }
    public static func sepia(_ amount: Double) -> Self { .init("sepia(\(amount))") }
    public static func custom(_ raw: String) -> Self { .init(raw) }
}

extension Collection where Element == BackdropFilter {
    /// Joins multiple filters into a valid CSS list.
    var cssList: String { map(\.css).joined(separator: " ") }
}
