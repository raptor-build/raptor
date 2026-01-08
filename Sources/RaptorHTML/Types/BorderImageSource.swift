//
// BorderImageSource.swift
// RaptorHTML
// https://raptor.build
// See LICENSE for license information.
//

import Foundation

/// Defines the image source for a border image.
public enum BorderImageSource: Sendable, CustomStringConvertible {
    /// No image source (CSS `none`).
    case none

    /// URL to an external image file.
    case url(URL)

    /// A CSS gradient function (e.g. linear-gradient, radial-gradient).
    case gradient(String)

    /// A reference to another element by ID (CSS `element()` function).
    case element(String)

    /// A cross-fade between multiple images.
    case crossFade(String)

    /// Any other custom CSS image function or raw value.
    case custom(String)

    public var description: String {
        switch self {
        case .none:
            return "none"
        case .url(let url):
            return "url(\(url.absoluteString))"
        case .gradient(let value):
            return value.hasPrefix("linear-gradient") ||
                   value.hasPrefix("radial-gradient") ||
                   value.hasPrefix("conic-gradient")
                ? value
                : "linear-gradient(\(value))"
        case .element(let id):
            return "element(\(id))"
        case .crossFade(let value):
            return "cross-fade(\(value))"
        case .custom(let value):
            return value
        }
    }

    var css: String { description }
}
