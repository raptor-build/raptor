//
// Color.swift
// RaptorHTML
// https://raptor.build
// See LICENSE for license information.
//

// swiftlint:disable identifier_name

/// Represents a CSS color value in a type-safe and expressive way.
///
/// `Color` supports common CSS color formats such as:
/// - Named colors (`.red`, `.blue`, `.black`)
/// - RGB(A) components (`.rgb(255, 0, 0)`, `.rgba(255, 0, 0, 0.5)`)
/// - HSL(A) components (`.hsl(120, 100%, 50%)`, `.hsla(240, 100%, 50%, 0.5)`)
/// - Hex values (`.hex("#ff0000")`)
/// - CSS system keywords (`.currentColor`, `.transparent`, `.inherit`)
public enum Color: Hashable, Equatable, Sendable, CustomStringConvertible {
    /// A predefined named CSS color (e.g. `"red"`, `"navy"`, `"rebeccapurple"`).
    case named(String)

    /// RGB color using integer components (0–255).
    case rgb(Int, Int, Int, Double = 1.0)

    /// Display-P3 color space using normalized (0–1) components.
    /// - Parameters:
    ///   - r: Red component (0–1)
    ///   - g: Green component (0–1)
    ///   - b: Blue component (0–1)
    ///   - a: Alpha value (0.0–1.0)
    case displayP3(Double, Double, Double, Double = 1.0)

    /// HSLA color using hue (0–360°), saturation/lightness (%), and alpha (0.0–1.0).
    case hsl(Double, Double, Double, Double = 1.0)

    /// A hexadecimal color string (e.g. `"#FF0000"` or `"FF0000"`).
    case hex(String)

    /// A custom CSS color string not otherwise represented.
    case custom(String)

    /// Returns the CSS string representation of the color.
    public var css: String {
        switch self {
        case .named(let name):
            return name
        case .rgb(let r, let g, let b, let a):
            let opacity = Int(a * 100)
            return "rgb(\(r) \(g) \(b) / \(opacity)%)"
        case .displayP3(let r, let g, let b, let a):
            return "color(display-p3 \(r) \(g) \(b) / \(a))"
        case .hsl(let h, let s, let l, let a):
            return if a == 1 {
                "hsl(\(h) \(s)% \(l)%)"
            } else {
                "hsl(\(h) \(s)% \(l)% / \(a))"
            }
        case .hex(let value):
            return value.hasPrefix("#") ? value : "#\(value)"
        case .custom(let value):
            return value
        }
    }

    public var description: String { css }
}

public extension Color {
    static let transparent: Self = .custom("transparent")
    static let currentColor: Self = .custom("currentColor")
}

public extension Color {
    /// Creates a copy of the color with the given opacity applied.
    /// - Parameter value: The alpha (opacity) between 0.0 and 1.0.
    /// - Returns: A new `Color` with the adjusted alpha value.
    func opacity(_ value: Double) -> Color {
        switch self {
        case .rgb(let r, let g, let b, _):
            .rgb(r, g, b, value)
        case .hsl(let h, let s, let l, _):
            .hsl(h, s, l, value)
        case .hex(let hex):
            .custom("\(hex.hasPrefix("#") ? hex : "#\(hex)")/\(value)")
        default:
            .custom("\(css)/\(value)")
        }
    }
}

// swiftlint:enable identifier_name
