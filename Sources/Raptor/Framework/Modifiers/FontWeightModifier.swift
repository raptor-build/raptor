//
// FontWeight.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

public extension HTML {
    /// Adjusts the font weight (boldness) of this font.
    /// - Parameter weight: The new font weight.
    /// - Returns: A new `Text` instance with the updated weight.
    func fontWeight(_ weight: Font.Weight) -> some HTML {
        self.style(.fontWeight(weight.html))
    }
}

public extension InlineContent {
    /// Adjusts the font weight (boldness) of this font.
    /// - Parameter weight: The new font weight.
    /// - Returns: A new `Text` instance with the updated weight.
    func fontWeight(_ weight: Font.Weight) -> some InlineContent {
        self.style(.fontWeight(weight.html))
    }
}
