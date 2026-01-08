//
// HorizontalSizeClass.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

/// A three-level width classification used to adapt layout and typography
/// to different browser or viewport sizes: compact, regular, and expanded.
public struct HorizontalSizeClass: Hashable, Sendable, Comparable, CaseIterable, EnvironmentEffectValue {
    /// A numeric rank used for ordering.
    let rawValue: Int

    /// Compact horizontal size (e.g., phones or narrow windows).
    public static let compact = HorizontalSizeClass(rawValue: 0)

    /// Regular horizontal size (e.g., tablets or medium-width windows).
    public static let regular = HorizontalSizeClass(rawValue: 1)

    /// Expanded horizontal size (e.g., desktops or wide layouts).
    public static let expanded = HorizontalSizeClass(rawValue: 2)

    public static var allCases: [HorizontalSizeClass] {
        [.compact, .regular, .expanded]
    }

    public static func < (lhs: HorizontalSizeClass, rhs: HorizontalSizeClass) -> Bool {
        lhs.rawValue < rhs.rawValue
    }
}

extension HorizontalSizeClass {
    static let none: Self = .init(rawValue: -10_000)
}

extension HorizontalSizeClass {
    /// The breakpoint width associated with this classification,
    /// used when generating responsive CSS rules.
    var breakpoint: LengthUnit {
        switch self {
        case .compact: .px(0)
        case .regular: Breakpoint.small.value
        case .expanded: Breakpoint.large.value
        default: .px(0) // failsafe
        }
    }
}

extension HorizontalSizeClass: MediaFeature {
    package var condition: String {
        "min-width: \(breakpoint.css)"
    }
}

extension HorizontalSizeClass: RangedMediaFeatureConvertible {
    var mediaFeatures: [any MediaFeature] {
        switch self {
        case .compact:
            [Breakpoint.small.maxWidth]
        case .regular:
            [Breakpoint.small.minWidth, Breakpoint.large.maxWidth]
        case .expanded:
            [Breakpoint.large.minWidth]
        default:
            []
        }
    }
}
