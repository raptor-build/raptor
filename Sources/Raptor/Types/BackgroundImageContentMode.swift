//
// BackgroundImageContentMode.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

/// The possible background sizes
public enum BackgroundImageContentMode: Sendable {
    /// This is the default value. The background image is displayed at its original size.
    case original

    /// Scales the background image to cover the entire container while maintaining its aspect ratio.
    case fill

    /// Scales the background image to fit within the container without
    case fit

    /// The exact width and height using length values (pixels, ems, percentages, auto etc.)
    case size(width: String, height: String)

    /// The CSS name of the size.
    var style: Property {
        switch self {
        case .original: .backgroundSize(.auto)
        case .fill: .backgroundSize(.cover)
        case .fit: .backgroundSize(.contain)
        case .size(let width, let height): .backgroundSize(.size(.custom(width), .custom(height)))
        }
    }
}
