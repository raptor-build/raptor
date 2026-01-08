//
// BackgroundSize.swift
// RaptorHTML
// https://raptor.build
// See LICENSE for license information.
//

/// Controls the scaling of a background image.
public enum BackgroundSize: Sendable {
    case auto
    case cover
    case contain
    case size(LengthUnit, LengthUnit?)

    var css: String {
        switch self {
        case .auto: "auto"
        case .cover: "cover"
        case .contain: "contain"
        case .size(let width, let height):
            if let height {
                "\(width.css) \(height.css)"
            } else {
                width.css
            }
        }
    }
}
