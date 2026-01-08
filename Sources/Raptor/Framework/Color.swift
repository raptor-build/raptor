//
// Color.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

// swiftlint:disable identifier_name

import Foundation

/// Represents a color in Raptor's theming system, supporting literal RGB values,
/// Display P3 colors, CSS variable references, HTML named colors,
/// and raw CSS color expressions.
public struct Color: CustomStringConvertible, Equatable, Hashable, Sendable {
    /// Represents supported color spaces for literal color creation.
    public enum ColorSpace: String, Sendable {
        /// Standard sRGB color space (default for web and most displays).
        case rgb
        /// Wide-gamut Display-P3 color space, used on Apple devices and HDR displays.
        case p3
    }

    /// Internal storage for color data.
    private enum Storage: Equatable, Hashable, Sendable {
        /// Standard sRGB color using integer RGB and percentage opacity.
        case rgb(red: Int, green: Int, blue: Int, opacity: Int)
        /// Display-P3 color using 0–1 component values and opacity in percentage (0–100).
        case p3(red: Double, green: Double, blue: Double, opacity: Int)
        /// CSS variable reference with opacity in percentage (0–100).
        case variable(name: String, opacity: Int)
        /// HTML named color (e.g. `"red"`, `"royalblue"`).
        case html(name: String, opacity: Int)
        /// Raw CSS expression, such as `color-mix()` or gradient definitions.
        case expression(value: String, opacity: Int)
    }

    /// Backing storage for this color.
    private let storage: Storage

    /// The standard set of control attributes for HTML elements.
    public var attributes: CoreAttributes = .init()

    /// The content and behavior of this HTML.
    public var body: Never { fatalError() }

    /// Returns the CSS string representation of this color.
    public var description: String {
        switch storage {
        case .variable(let name, let opacity):
            if opacity >= 100 {
                return "var(\(name))"
            } else {
                return "color-mix(in srgb, var(\(name)) \(opacity)%, transparent)"
            }

        case .rgb(let r, let g, let b, let o):
            return "rgb(\(r) \(g) \(b) / \(o)%)"

        case .html(let name, let opacity):
            if opacity >= 100 {
                return name
            } else {
                return "color-mix(in srgb, \(name) \(opacity)%, transparent)"
            }

        case .p3(let r, let g, let b, let o):
            return "color(display-p3 \(r) \(g) \(b) / \(Double(o) / 100))"

        case .expression(let value, let opacity):
            if opacity >= 100 {
                return value
            } else {
                return "color-mix(in srgb, \(value) \(opacity)%, transparent)"
            }
        }
    }

    /// Creates a color using a standard HTML color name.
    /// - Parameter html: The HTML named color (e.g. `.red`, `.royalBlue`, `.aliceBlue`).
    /// - Note: This emits a CSS keyword like `red` or `royalblue` rather than a hex value.
    public init(html: HTMLColor) {
        self.storage = .html(name: html.rawValue, opacity: 100)
    }

    /// Creates a new color from integer RGB components.
    /// - Parameters:
    ///   - red: Red component (0–255).
    ///   - green: Green component (0–255).
    ///   - blue: Blue component (0–255).
    ///   - opacity: Opacity percentage (0–100%).
    public init(red: Int, green: Int, blue: Int, opacity: Percentage = 100%) {
        self.storage = .rgb(red: red, green: green, blue: blue, opacity: opacity.roundedValue)
    }

    /// Creates a color in a specific color space using normalized floating-point components.
    /// - Parameters:
    ///   - colorSpace: The color space to use — `.sRGB` or `.displayP3`.
    ///   - red: Red component (0–1).
    ///   - green: Green component (0–1).
    ///   - blue: Blue component (0–1).
    ///   - opacity: Opacity (0–1, default = 1).
    public init(colorSpace: ColorSpace = .rgb, red: Double, green: Double, blue: Double, opacity: Double = 1) {
        let clampedOpacity = Int((min(max(opacity, 0), 1)) * 100)
        switch colorSpace {
        case .rgb:
            // Convert normalized values (0–1) to integer RGB components (0–255)
            let r = Int(red * 255)
            let g = Int(green * 255)
            let b = Int(blue * 255)
            self.storage = .rgb(red: r, green: g, blue: b, opacity: clampedOpacity)
        case .p3:
            self.storage = .p3(red: red, green: green, blue: blue, opacity: clampedOpacity)
        }
    }

    /// Creates a grayscale color from a white intensity value.
    /// - Parameters:
    ///   - white: White intensity (0–1).
    ///   - opacity: Opacity value (0–1).
    public init(white: Double, opacity: Double = 1) {
        let intWhite = Int(white * 255)
        let clampedOpacity = Int(min(max(opacity, 0), 1) * 100)
        self.storage = .rgb(red: intWhite, green: intWhite, blue: intWhite, opacity: clampedOpacity)
    }

    /// Creates a color from a CSS variable reference.
    /// - Parameters:
    ///   - variable: The CSS variable name (e.g. `--r-blue`).
    ///   - opacity: Opacity multiplier (0–1, default = 1.0).
    init(variable: String, opacity: Double = 1.0) {
        let clampedOpacity = Int(min(max(opacity, 0), 1) * 100)
        self.storage = .variable(name: variable, opacity: clampedOpacity)
    }

    /// Creates a raw CSS color expression (e.g. `color-mix()` or `color(display-p3 ...)`).
    /// - Parameters:
    ///   - value: The CSS color expression to store.
    ///   - opacity: Opacity percentage (0–100).
    private init(expression value: String, opacity: Int = 100) {
        let clampedOpacity = min(max(opacity, 0), 100)
        self.storage = .expression(value: value, opacity: clampedOpacity)
    }

    /// Creates a new color from a hex string (e.g. `#FFE700` or `#FFE700FF`).
    /// - Parameter hex: The hexadecimal color string.
    public init(hex: String) {
        let red, green, blue, alpha: Int
        if hex.hasPrefix("#") {
            let start = hex.index(hex.startIndex, offsetBy: 1)
            let hexColor = String(hex[start...])
            var hexNumber: UInt64 = 0
            if Scanner(string: hexColor).scanHexInt64(&hexNumber) {
                if hexColor.count == 8 {
                    red = Int((hexNumber & 0xff000000) >> 24)
                    green = Int((hexNumber & 0x00ff0000) >> 16)
                    blue = Int((hexNumber & 0x0000ff00) >> 8)
                    alpha = Int(hexNumber & 0x000000ff)
                    self.storage = .rgb(red: red, green: green, blue: blue, opacity: alpha)
                    return
                } else if hexColor.count == 6 {
                    red = Int((hexNumber & 0xff0000) >> 16)
                    green = Int((hexNumber & 0x00ff00) >> 8)
                    blue = Int(hexNumber & 0x0000ff)
                    self.storage = .rgb(red: red, green: green, blue: blue, opacity: 100)
                    return
                }
            }
        }
        self.storage = .rgb(red: 0, green: 0, blue: 0, opacity: 100)
    }

    public static let accent = Color(variable: "--accent")
    public static let primary = Color(variable: "--fg")
    public static let secondary = Color(variable: "--fg-secondary")
    public static let tertiary = Color(variable: "--fg-tertiary")

    public static let background = Color(variable: "--bg")
    public static let secondaryBackground = Color(variable: "--bg-secondary")
    public static let tertiaryBackground = Color(variable: "--bg-tertiary")
    public static let quaternaryBackground = Color(variable: "--bg-quaternary")
    public static let quinaryBackground = Color(variable: "--bg-quinary")

    public static let red = Color(variable: "--r-red")
    public static let orange = Color(variable: "--r-orange")
    public static let yellow = Color(variable: "--r-yellow")
    public static let green = Color(variable: "--r-green")
    public static let mint = Color(variable: "--r-mint")
    public static let teal = Color(variable: "--r-teal")
    public static let cyan = Color(variable: "--r-cyan")
    public static let blue = Color(variable: "--r-blue")
    public static let indigo = Color(variable: "--r-indigo")
    public static let purple = Color(variable: "--r-purple")
    public static let pink = Color(variable: "--r-pink")
    public static let brown = Color(variable: "--r-brown")
    public static let gray = Color(variable: "--r-gray")

    public static let black = Color(hex: "#000000")
    public static let white = Color(hex: "#FFFFFF")
    public static let clear = Color(red: 0, green: 0, blue: 0, opacity: 0%)

    /// Returns a version of the color with adjusted opacity.
    /// - Parameter opacity: Multiplier (0–1) applied to the current opacity.
    /// - Returns: A new `Color` with modified opacity.
    public func opacity(_ opacity: Double) -> Self {
        let multiplier = min(max(opacity, 0), 1)
        switch storage {
        case .variable(let name, let existingOpacity):
            let newOpacity = Int(Double(existingOpacity) * multiplier)
            return Color(variable: name, opacity: Double(newOpacity) / 100)
        case .rgb(let r, let g, let b, let o):
            let newOpacity = Int(Double(o) * multiplier)
            return Color(
                colorSpace: .rgb,
                red: Double(r),
                green: Double(g),
                blue: Double(b),
                opacity: Double(newOpacity) / 100)
        case .p3(let r, let g, let b, let o):
            let newOpacity = Int(Double(o) * multiplier)
            return Color(
                colorSpace: .p3,
                red: r,
                green: g,
                blue: b,
                opacity: Double(newOpacity) / 100)
        case .expression(let value, let existingOpacity):
            let newOpacity = Int(Double(existingOpacity) * multiplier)
            return Color(expression: value, opacity: newOpacity)
        case .html(let name, let existingOpacity):
            let newOpacity = Int(Double(existingOpacity) * multiplier)
            return Color(expression: name, opacity: newOpacity)
        }
    }

    /// Returns a weighted variant of the color by mixing with white or black.
    /// - Parameter weight: The weighting configuration (lighten/darken amount).
    /// - Returns: A new `Color` adjusted toward white or black.
    public func weighted(_ weight: ColorWeight) -> Self {
        switch storage {
        case .rgb(let r, let g, let b, let o):
            let mixColor = weight.mixColor
            let percentage = Double(weight.mixPercentage) / 100.0
            let newRed = Int(Double(r) * (1 - percentage) + Double(mixColor.red) * percentage)
            let newGreen = Int(Double(g) * (1 - percentage) + Double(mixColor.green) * percentage)
            let newBlue = Int(Double(b) * (1 - percentage) + Double(mixColor.blue) * percentage)
            return Color(
                colorSpace: .rgb,
                red: Double(newRed),
                green: Double(newGreen),
                blue: Double(newBlue),
                opacity: Double(o) / 100)

        case .p3(let r, let g, let b, let o):
            let mixColor = weight.mixColor
            let percentage = Double(weight.mixPercentage) / 100.0
            let mixRed = Double(mixColor.red) / 255.0
            let mixGreen = Double(mixColor.green) / 255.0
            let mixBlue = Double(mixColor.blue) / 255.0
            let newRed = r * (1 - percentage) + mixRed * percentage
            let newGreen = g * (1 - percentage) + mixGreen * percentage
            let newBlue = b * (1 - percentage) + mixBlue * percentage
            return Color(colorSpace: .p3, red: newRed, green: newGreen, blue: newBlue, opacity: Double(o) / 100)

        case .variable(let name, let o):
            let mixWith = weight.mixColor
            let percent = 100 - weight.mixPercentage
            let css = "color-mix(in srgb, var(\(name)) \(percent)%, \(mixWith.description))"
            return Color(expression: css, opacity: o)

        case .expression(let value, let o):
            let mixWith = weight.mixColor
            let percent = 100 - weight.mixPercentage
            let css = "color-mix(in srgb, \(value) \(percent)%, \(mixWith.description))"
            return Color(expression: css, opacity: o)

        case .html(let name, let o):
            let mixWith = weight.mixColor
            let percent = 100 - weight.mixPercentage
            let css = "color-mix(in srgb, \(name) \(percent)%, \(mixWith.description))"
            return Color(expression: css, opacity: o)
        }
    }

    /// Returns the red component (0–255) if RGB or equivalent if P3; otherwise 0.
    var red: Int {
        switch storage {
        case .rgb(let r, _, _, _): return r
        case .p3(let r, _, _, _): return Int(r * 255)
        default: return 0
        }
    }

    /// Returns the green component (0–255) if RGB or equivalent if P3; otherwise 0.
    var green: Int {
        switch storage {
        case .rgb(_, let g, _, _): return g
        case .p3(_, let g, _, _): return Int(g * 255)
        default: return 0
        }
    }

    /// Returns the blue component (0–255) if RGB or equivalent if P3; otherwise 0.
    var blue: Int {
        switch storage {
        case .rgb(_, _, let b, _): return b
        case .p3(_, _, let b, _): return Int(b * 255)
        default: return 0
        }
    }

    /// Returns the opacity percentage (0–100%) for all color types.
    var opacity: Int {
        switch storage {
        case .rgb(_, _, _, let o): return o
        case .p3(_, _, _, let o): return o
        case .variable(_, let o): return o
        case .expression(_, let o): return o
        case .html(_, let o): return o
        }
    }
}

extension Color: HTML {
    public func render() -> Markup {
        Section()
            .attributes(attributes)
            .class("color")
            .background(self)
            .render()
    }
}

extension Color {
    /// Converts this `Raptor.Color` into a `RaptorHTML.Color` representation.
    var html: RaptorHTML.Color {
        switch storage {
        case .rgb(let r, let g, let b, let opacity):
            return .rgb(r, g, b, Double(opacity) / 100.0)

        case .p3(let r, let g, let b, let opacity):
            // Preserve Display-P3, no gamut reduction
            return .displayP3(r, g, b, Double(opacity) / 100.0)

        case .html(let name, let opacity):
            let alpha = Double(opacity) / 100.0
            return alpha >= 1
                ? .named(name)
                : .custom("color-mix(in srgb, \(name) \(opacity)%, transparent)")

        case .variable(let name, let opacity):
            let alpha = Double(opacity) / 100.0
            return .custom(alpha >= 1
                ? "var(\(name))"
                : "color-mix(in srgb, var(\(name)) \(opacity)%, transparent)")

        case .expression(let value, _):
            return .custom(value)
        }
    }
}

// swiftlint:enable identifier_name
