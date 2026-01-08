//
// ScrollbarColor.swift
// RaptorHTML
// https://raptor.build
// See LICENSE for license information.
//

/// Represents the color configuration for scrollbars.
///
/// Example:
/// ```swift
/// .scrollbarColor(.init(thumb: .gray, track: .lightGray))
/// ```
public struct ScrollbarColor: Sendable, Hashable {
    let thumb: Color
    let track: Color?

    var css: String {
        if let track {
            "\(thumb.css) \(track.css)"
        } else {
            thumb.css
        }
    }

    /// Creates a custom scrollbar color configuration.
    public init(thumb: Color, track: Color? = nil) {
        self.thumb = thumb
        self.track = track
    }

    /// Restores system-default scrollbar colors.
    public static let auto = Self(thumb: .transparent, track: nil)
}
