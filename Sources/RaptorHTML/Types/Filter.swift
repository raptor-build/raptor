//
// Filter.swift
// RaptorHTML
// https://raptor.build
// See LICENSE for license information.
//

/// Represents visual filter effects applied directly to an element, such as blur, brightness, or contrast.
public struct Filter: Sendable, Hashable {
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
    public static func dropShadow(x: LengthUnit, y: LengthUnit, blur: LengthUnit? = nil, color: Color? = nil) -> Self {
        var parts = ["drop-shadow(\(x.css) \(y.css)"]
        if let blur { parts.append(blur.css) }
        if let color { parts.append(color.css) }
        return .init(parts.joined(separator: " ") + ")")
    }

    public static func combine(_ effects: [Self]) -> Self {
        .init(effects.map(\.css).joined(separator: " "))
    }

    public static func custom(_ raw: String) -> Self { .init(raw) }
}
