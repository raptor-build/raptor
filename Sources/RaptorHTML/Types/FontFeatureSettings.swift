//
// FontFeatureSettings.swift
// RaptorHTML
// https://raptor.build
// See LICENSE for license information.
//

/// Represents OpenType font feature settings for advanced typographic control.
///
/// Each option corresponds to a specific OpenType feature tag (e.g. `"liga"` for ligatures).
/// Multiple options can be combined to enable multiple features.
///
/// Example:
/// ```swift
/// .fontFeatureSettings([.ligatures, .kerning])
/// ```
public struct FontFeatureSettings: OptionSet, Sendable, Hashable {
    public let rawValue: UInt64

    private static let tagMap: [FontFeatureSettings: String] = [
        .ligatures: "\"liga\" 1",
        .discretionaryLigatures: "\"dlig\" 1",
        .smallCaps: "\"smcp\" 1",
        .oldstyleFigures: "\"onum\" 1",
        .tabularFigures: "\"tnum\" 1",
        .kerning: "\"kern\" 1",
        .slashedZero: "\"zero\" 1"
    ]

    var css: String {
        let tags = Self.tagMap.keys.filter { contains($0) }
        if tags.isEmpty { return "normal" }
        return tags.compactMap { Self.tagMap[$0] }.joined(separator: ", ")
    }

    public init(rawValue: UInt64) {
        self.rawValue = rawValue
    }

    /// Enables standard ligatures (`"liga"`).
    public static let ligatures = Self(rawValue: 1 << 0)

    /// Enables discretionary ligatures (`"dlig"`).
    public static let discretionaryLigatures = Self(rawValue: 1 << 1)

    /// Enables small caps (`"smcp"`).
    public static let smallCaps = Self(rawValue: 1 << 2)

    /// Enables oldstyle figures (`"onum"`).
    public static let oldstyleFigures = Self(rawValue: 1 << 3)

    /// Enables tabular figures (`"tnum"`).
    public static let tabularFigures = Self(rawValue: 1 << 4)

    /// Enables kerning (`"kern"`).
    public static let kerning = Self(rawValue: 1 << 5)

    /// Enables slashed zero (`"zero"`).
    public static let slashedZero = Self(rawValue: 1 << 6)
}
