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

    /// Scales the font so it visually matches the size of the base font.
    var sizeAdjust = "100%"

    /// Optional ascent metrics override.
    var ascentOverride = "normal"

    /// Optional descent metrics override .
    var descentOverride = "normal"

    /// Optional line-gap override.
    var lineGapOverride = "normal"

    /// Creates a source from a font located at the given URL.
    /// - Parameters:
    ///   - url: The URL where the font file can be found.
    ///   - weight: The weight of this font variant, defaulting to `.regular`.
    ///   - variant: The style of this font variant, defaulting to `.normal`.
    public init(
        url: URL,
        weight: Font.Weight = .regular,
        variant: Font.Variant = .normal
    ) {
        self.weight = weight
        self.variant = variant
        self.url = url
    }

    /// Creates a font source using a file located in `Assets/fonts/`.
    /// - Parameters:
    ///   - filename: The name of the font file located in the fonts directory.
    ///   - weight: The weight of this font variant, defaulting to `.regular`.
    ///   - variant: The style of this font variant, defaulting to `.normal`.
    public init(
        file filename: String,
        weight: Font.Weight = .regular,
        variant: Font.Variant = .normal
    ) {
        let path = "/fonts/\(filename)"
        if let url = URL(string: path) {
            self.init(url: url, weight: weight, variant: variant)
        } else {
            BuildContext.logError(.invalidFontFilename(filename))
            // Avoids crashing or emitting a broken @font-face.
            self.init(url: URL(static: "about:blank"))
        }
    }
}

public extension FontSource {
    /// Scales the font so its visual size aligns with the base font.
    /// - Parameter scale: A unitless multiplier applied to the font’s metrics.
    /// - Returns: A font source with the adjusted visual scale.
    func scale(_ scale: Double) -> Self {
        var copy = self
        copy.sizeAdjust = LengthUnit.percent(scale).css
        return copy
    }

    /// Overrides the font’s ascent metric.
    /// - Parameter scale: A unitless multiplier relative to the font’s em square.
    /// - Returns: A font source with the overridden ascent metric.
    func ascent(_ scale: Double) -> Self {
        var copy = self
        copy.ascentOverride = LengthUnit.percent(scale).css
        return copy
    }

    /// Overrides the font’s descent metric.
    /// - Parameter scale: A unitless multiplier relative to the font’s em square.
    /// - Returns: A font source with the overridden descent metric.
    func descent(_ scale: Double) -> Self {
        var copy = self
        copy.descentOverride = LengthUnit.percent(scale).css
        return copy
    }

    /// Overrides the font’s line gap metric.
    /// - Parameter scale: A unitless multiplier relative to the font’s em square.
    /// - Returns: A font source with the overridden line gap metric.
    func lineGap(_ scale: Double) -> Self {
        var copy = self
        copy.lineGapOverride = LengthUnit.percent(scale).css
        return copy
    }
}
