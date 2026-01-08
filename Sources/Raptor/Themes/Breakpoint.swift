//
// Breakpoint.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

/// A representation of standard responsive design breakpoints.
enum Breakpoint: Int, Sendable, Hashable, Comparable, CaseIterable {
    /// Extra small screens (0px)
    case xSmall = 0

    /// Small screens (575px)
    case small = 575

    /// Medium screens (768px)
    case medium = 768

    /// Large screens (1024px)
    case large = 1024

    /// Extra large screens (1440px)
    case xLarge = 1440

    /// The default minimum width value for this breakpoint (used with min-width media queries)
    var value: LengthUnit {
        .px(Double(self.rawValue))
    }

    /// A `min-width` media feature matching this breakpoint.
    var minWidth: MediaFeature {
        WidthMediaFeature(name: "min-width", value: value)
    }

    /// A `max-width` media feature matching this breakpoint.
    var maxWidth: MediaFeature {
        WidthMediaFeature(name: "max-width", value: value)
    }

    /// Implements the `Comparable` protocol using raw pixel values.
    static func < (lhs: Breakpoint, rhs: Breakpoint) -> Bool {
        lhs.rawValue < rhs.rawValue
    }

    /// All supported breakpoints in order.
    static var allCases: [Breakpoint] {
        [.xSmall, .small, .medium, .large, .xLarge]
    }
}
