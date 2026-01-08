//
// TextEmphasisStyle.swift
// RaptorHTML
// https://raptor.build
// See LICENSE for license information.
//

/// Defines the style of emphasis marks applied to text.
///
/// Example:
/// ```swift
/// .textEmphasisStyle(.filled(.circle))
/// ```
public enum TextEmphasisStyle: Sendable, Hashable {
    case none
    case filled(Shape)
    case open(Shape)
    case custom(String)

    /// The shape of the emphasis mark.
    public enum Shape: String, Sendable, Hashable {
        case dot
        case circle
        case doubleCircle = "double-circle"
        case triangle
        case sesame
    }

    var css: String {
        switch self {
        case .none: "none"
        case .filled(let shape): "filled \(shape.rawValue)"
        case .open(let shape): "open \(shape.rawValue)"
        case .custom(let symbol): "\"\(symbol)\""
        }
    }
}
