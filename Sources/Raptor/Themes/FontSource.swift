//
// FontSource.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

import Foundation

/// A type that represents a source for a font, including its name, weight, style, and location.
///
/// Use `FontSource` to define where font files can be found and their properties. For example:
///
/// ```swift
/// // Local font
/// var fontFamilyBase = Font(
///     name: "valkyrie_a_regular",
///     source: "/fonts/valkyrie_a_regular.woff2"
/// )
///
/// // Remote font
/// var fontFamilyBase = Font(
///     name: "Lato",
///     source: "https://fonts.googleapis.com/css2?family=Lato" +
///            "?ital,wght@" +
///            "0,100;" +  // normal thin
///            "0,300;" +  // normal light
///            "0,400;" +  // normal regular
///            "0,700;" +  // normal bold
///            "0,900;" +  // normal black
///            "1,100;" +  // italic thin
///            "1,300;" +  // italic light
///            "1,400;" +  // italic regular
///            "1,700;" +  // italic bold
///            "1,900" +   // italic black
///            "&display=swap"
/// )
/// ```
public struct FontSource: Hashable, Equatable, Sendable {
    /// The weight (boldness) of this font variant.
    let weight: Font.Weight

    /// The style (normal, italic, or oblique) of this font variant.
    let variant: Font.Variant

    /// The URL where the font file can be found, if it's a web font.
    let url: URL

    /// Optional ascent metrics override.
    let ascentOverride: String

    /// Optional descent metrics override .
    let descentOverride: String

    /// Optional line-gap override (.
    let lineGapOverride: String

    /// Creates a font source with a remote URL.
    /// - Parameters:
    ///   - url: The URL where the font file can be found.
    ///   - weight: The weight of this font variant, defaulting to `.regular`.
    ///   - variant: The style of this font variant, defaulting to `.normal`.
    ///   - ascentMetric: Optional ascent override percentage.
    ///   - descentMetric: Optional descent override percentage.
    ///   - lineGapMetric: Optional line-gap override percentage.
    public init(
        url: URL,
        weight: Font.Weight = .regular,
        variant: Font.Variant = .normal,
        ascent ascentMetric: Double? = nil,
        descent descentMetric: Double? = nil,
        lineGap lineGapMetric: Double? = nil
    ) {
        self.weight = weight
        self.variant = variant
        self.url = url

        self.ascentOverride = percent(ascentMetric)
        self.descentOverride = percent(descentMetric)
        self.lineGapOverride = percent(lineGapMetric)

        func percent(_ value: Double?) -> String {
            guard let value else { return "normal" }
            return (value * 100).formatted(.number.precision(.fractionLength(0))) + "%"
        }
    }
}
