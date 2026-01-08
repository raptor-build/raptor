//
// LetterSpacingModifier.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

public extension HTML {
    /// Adjusts the spacing between letters in text using pixels.
    /// - Parameter pixels: The amount of spacing to apply between letters in pixels
    /// - Returns: A modified copy of the element with letter spacing applied
    func letterSpacing(_ pixels: Int) -> some HTML {
        self.style(.letterSpacing(.px(pixels)))
    }
}

public extension InlineContent {
    /// Adjusts the spacing between letters in inline text using pixels.
    /// - Parameter pixels: The amount of spacing to apply between letters in pixels
    /// - Returns: A modified copy of the element with letter spacing applied
    func letterSpacing(_ pixels: Int) -> some InlineContent {
        self.style(.letterSpacing(.px(pixels)))
    }
}
