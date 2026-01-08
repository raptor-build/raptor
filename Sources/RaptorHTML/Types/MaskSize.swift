//
// MaskSize.swift
// RaptorHTML
// https://raptor.build
// See LICENSE for license information.
//

/// Defines the size of the mask image.
public enum MaskSize: Sendable {
    case auto
    case cover
    case contain
    case length(LengthUnit, LengthUnit?)

    var css: String {
        switch self {
        case .auto: "auto"
        case .cover: "cover"
        case .contain: "contain"
        case .length(let width, let height):
            if let height {
                "\(width.css) \(height.css)"
            } else {
                width.css
            }
        }
    }
}
