//
// Gradient.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

/// A gradient that transitions between colors.
public struct Gradient: CustomStringConvertible, Sendable {
    /// The type of gradient to render
    public enum GradientType: Sendable {
        /// A linear gradient that transitions between colors along a line
        case linear(angle: Int)

        /// A radial gradient that transitions between colors from a center point
        case radial

        /// A conic gradient that transitions between colors around a center point
        case conic(angle: Int)
    }

    /// The colors to use in the gradient
    private let colors: [Color]

    /// The type of gradient to render
    private let type: GradientType

    /// Creates a gradient with the specified colors and type
    /// - Parameters:
    ///   - colors: Two or more colors to use for the gradient
    ///   - type: The type of gradient to create
    public init(colors: [Color], type: GradientType) {
        self.colors = colors
        self.type = type
    }

    /// The CSS representation of this gradient
    public var description: String {
        let colorStops = colors.enumerated().map { index, color in
            let percentage = Double(index) / Double(max(1, colors.count - 1)) * 100
            return "\(color) \(percentage)%"
        }.joined(separator: ", ")

        switch type {
        case .linear(let angle):
            return "linear-gradient(\(angle)deg, \(colorStops))"
        case .radial:
            return "radial-gradient(circle at center, \(colorStops))"
        case .conic(let angle):
            return "conic-gradient(from \(angle)deg at center, \(colorStops))"
        }
    }

    /// The inline styles required to create this gradient.
    var styles: [Property] {
        [.backgroundImage(self.html),
         .backgroundClip(.text),
         .color(.transparent)
        ]
    }
}

public extension Gradient {
    /// Creates a linear gradient between two points
    /// - Parameters:
    ///   - colors: The colors to use in the gradient
    ///   - startPoint: The starting point of the gradient
    ///   - endPoint: The ending point of the gradient
    /// - Returns: A linear gradient
    static func linearGradient(
        colors: Color..., from
        startPoint: UnitPoint,
        to endPoint: UnitPoint
    ) -> Gradient {
        let angle = Int(startPoint.degrees(to: endPoint))
        return Gradient(colors: colors, type: .linear(angle: angle))
    }

    /// Creates a radial gradient that transitions between colors from a center point
    /// - Parameter colors: The colors to use in the gradient
    /// - Returns: A radial gradient
    static func radialGradient(colors: Color...) -> Gradient {
        Gradient(colors: colors, type: .radial)
    }

    /// Creates a conic gradient that transitions between colors around a center point
    /// - Parameters:
    ///   - colors: The colors to use in the gradient
    ///   - angle: The starting angle in degrees
    /// - Returns: A conic gradient
    static func conicGradient(colors: Color..., angle: Int = 0) -> Gradient {
        Gradient(colors: colors, type: .conic(angle: angle))
    }
}

extension Gradient {
    /// Converts this `Raptor.Gradient` to a `RaptorHTML.Gradient` representation.
    ///
    /// This bridges Raptor’s simpler gradient model to RaptorHTML’s richer, type-safe gradient system.
    /// The conversion attempts to preserve angle and color stop semantics.
    var html: RaptorHTML.Gradient {
        // Convert Raptor.Color → RaptorHTML.Color
        let stops: [RaptorHTML.Gradient.ColorStop] = colors.enumerated().map { index, color in
            let position = Double(index) / Double(max(1, colors.count - 1)) * 100
            return RaptorHTML.Gradient.ColorStop(color.html, position: position)
        }

        return switch type {
        case .linear(let angle):
            .linear(.degrees(Double(angle)), stops.map(\.self))
        case .radial:
            .radial(.circle, at: .center, stops.map(\.self))
        case .conic(let angle):
            .conic(from: .degrees(Double(angle)), at: .center, stops.map(\.self))
        }
    }
}
