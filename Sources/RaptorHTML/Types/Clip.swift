//
// Clip.swift
// RaptorHTML
// https://raptor.build
// See LICENSE for license information.
//

/// Defines a rectangular clipping region for an absolutely positioned element.
///
/// This is a **legacy property** superseded by `clip-path`, but still supported for backward compatibility.
/// It can restrict which parts of an element’s visual box are rendered.
///
/// Example:
/// ```swift
/// .clip(.rect(top: 0, right: 100, bottom: 100, left: 0))
/// ```
public enum Clip: Sendable, Hashable {
    /// No clipping (default behavior).
    case auto
    /// A rectangular clipping region in pixel units.
    case rect(top: Double, right: Double, bottom: Double, left: Double)
    /// Custom CSS clip expression (e.g., `"inset(10px 20px)"`).
    case custom(String)

    var css: String {
        switch self {
        case .auto:
            return "auto"
        case let .rect(top, right, bottom, left):
            let values = [top, right, bottom, left].map { "\($0)px" }.joined(separator: ", ")
            return "rect(\(values))"
        case let .custom(value):
            return value
        }
    }
}
