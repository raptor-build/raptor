//
// FontInlineModifier.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

/// A modifier that applies font styling to inline elements.
private struct FontInlineModifier: InlineContentModifier {
    /// The font configuration to apply.
    var font: Font

    func body(content: Content) -> some InlineContent {
        BuildContext.register(font)
        let attributes = FontModifier.attributes(for: font, includeStyle: true)
        var modified = content
        modified.attributes.merge(attributes)
        return modified
    }
}

public extension InlineContent {
    /// Adjusts the font of this text.
    /// - Parameter font: The font configuration to apply.
    /// - Returns: A new instance with the updated font.
    func font(_ font: Font) -> some InlineContent {
        modifier(FontInlineModifier(font: font))
    }
}
