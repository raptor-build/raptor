//
// MotionPath.swift
// RaptorHTML
// https://raptor.build
// See LICENSE for license information.
//

import Foundation

/// Defines the motion path for an element’s animation.
public enum MotionPath: Sendable, CustomStringConvertible {
    /// No motion path (`none`)
    case none

    /// A path defined using an SVG path string (e.g., `"M 0 0 L 100 100"`).
    case path(String)

    /// A reference to an external path via URL.
    case url(URL)

    /// A ray starting from an angle, with optional size and containment.
    case ray(angle: Angle, size: LengthUnit? = nil, contain: Bool = false)

    public var description: String {
        switch self {
        case .none:
            return "none"
        case .path(let string):
            return "path('\(string)')"
        case .url(let url):
            return "url(\(url.absoluteString))"
        case .ray(let angle, let size, let contain):
            var parts = ["ray(\(angle.css)"]
            if let size = size {
                parts.append(size.css)
            }
            if contain {
                parts.append("contain")
            }
            return parts.joined(separator: " ") + ")"
        }
    }

    var css: String { description }
}
