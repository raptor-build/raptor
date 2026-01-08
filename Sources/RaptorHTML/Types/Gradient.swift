//
// Gradient.swift
// RaptorHTML
// https://raptor.build
// See LICENSE for license information.
//

/// Represents any CSS gradient value (linear, radial, conic, or repeating).
public struct Gradient: Sendable, Hashable {
    public enum Kind: Equatable, Hashable, Sendable {
        /// A linear gradient (e.g. `linear-gradient(45deg, red, blue)`).
        case linear(angle: Angle? = nil)

        /// A radial gradient (e.g. `radial-gradient(circle at center, red, blue)`).
        case radial(shape: RadialShape = .circle, position: GradientPosition = .center)

        /// A conic gradient (e.g. `conic-gradient(from 90deg at center, red, blue)`).
        case conic(from: Angle? = nil, at: GradientPosition = .center)
        // swiftlint:disable:previous identifier_name

        /// Repeating linear gradient.
        case repeatingLinear(angle: Angle? = nil)

        /// Repeating radial gradient.
        case repeatingRadial(shape: RadialShape = .circle, position: GradientPosition = .center)

        /// Repeating conic gradient.
        case repeatingConic(from: Angle? = nil, at: GradientPosition = .center)
        // swiftlint:disable:previous identifier_name
    }

    public let kind: Kind
    public let stops: [ColorStop]

    /// Represents a single gradient color stop.
    public struct ColorStop: Hashable, Equatable, Sendable {
        public let color: Color
        public let position: Double? // percentage 0–100
        public init(_ color: Color, position: Double? = nil) {
            self.color = color
            self.position = position
        }
        public var css: String {
            if let pos = position {
                "\(color.css) \(pos)%"
            } else {
                color.css
            }
        }
    }

    public enum RadialShape: String, Equatable, Sendable {
        case circle
        case ellipse
        public var css: String { rawValue }
    }

    public enum GradientPosition: Equatable, Hashable, Sendable {
        case center
        case top
        case bottom
        case left
        case right
        case custom(x: String, y: String)

        public var css: String {
            switch self {
            case .center: "center"
            case .top: "top"
            case .bottom: "bottom"
            case .left: "left"
            case .right: "right"
            case .custom(let x, let y): "\(x) \(y)"
            }
        }
    }

    public init(kind: Kind, stops: [ColorStop]) {
        self.kind = kind
        self.stops = stops
    }

    public var css: String {
        let stopList = stops.map(\.css).joined(separator: ", ")
        switch kind {
        case .linear(let angle):
            return if let angle {
                "linear-gradient(\(angle.css), \(stopList))"
            } else {
                "linear-gradient(\(stopList))"
            }

        case .radial(let shape, let position):
            return "radial-gradient(\(shape.css) at \(position.css), \(stopList))"

        case .conic(let start, let end):
            return if let start {
                "conic-gradient(from \(start.css) at \(end.css), \(stopList))"
            } else {
                "conic-gradient(at \(end.css), \(stopList))"
            }

        case .repeatingLinear(let angle):
            return if let angle = angle {
                "repeating-linear-gradient(\(angle.css), \(stopList))"
            } else {
                "repeating-linear-gradient(\(stopList))"
            }

        case .repeatingRadial(let shape, let position):
            return "repeating-radial-gradient(\(shape.css) at \(position.css), \(stopList))"

        case .repeatingConic(let start, let end):
            return if let start {
                "repeating-conic-gradient(from \(start.css) at \(end.css), \(stopList))"
            } else {
                "repeating-conic-gradient(at \(end.css), \(stopList))"
            }
        }
    }
}

public extension Gradient {
    static func linear(_ angle: Angle? = nil, _ colors: ColorStop...) -> Self {
        Gradient(kind: .linear(angle: angle), stops: colors)
    }

    static func linear(_ angle: Angle? = nil, _ colors: [ColorStop]) -> Self {
        Gradient(kind: .linear(angle: angle), stops: colors)
    }

    static func radial(
        _ shape: RadialShape = .circle,
        at position: GradientPosition = .center,
        _ colors: ColorStop...
    ) -> Self {
        Gradient(kind: .radial(shape: shape, position: position), stops: colors)
    }

    static func radial(
        _ shape: RadialShape = .circle,
        at position: GradientPosition = .center,
        _ colors: [ColorStop]
    ) -> Self {
        Gradient(kind: .radial(shape: shape, position: position), stops: colors)
    }

    static func conic(
        from angle: Angle? = nil,
        at position: GradientPosition = .center,
        _ colors: ColorStop...
    ) -> Self {
        Gradient(kind: .conic(from: angle, at: position), stops: colors)
    }

    static func conic(
        from angle: Angle? = nil,
        at position: GradientPosition = .center,
        _ colors: [ColorStop]
    ) -> Self {
        Gradient(kind: .conic(from: angle, at: position), stops: colors)
    }

    static func repeatingLinear(_ angle: Angle? = nil, _ colors: ColorStop...) -> Self {
        Gradient(kind: .repeatingLinear(angle: angle), stops: colors)
    }

    static func repeatingRadial(
        _ shape: RadialShape = .circle,
        at position: GradientPosition = .center,
        _ colors: ColorStop...
    ) -> Self {
        Gradient(kind: .repeatingRadial(shape: shape, position: position), stops: colors)
    }

    static func repeatingConic(
        from angle: Angle? = nil,
        at position: GradientPosition = .center,
        _ colors: ColorStop...
    ) -> Self {
        Gradient(kind: .repeatingConic(from: angle, at: position), stops: colors)
    }
}
