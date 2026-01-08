//
// FontStyleInlineModifier.swift
// RaptorSamples
// https://raptor.build
// See LICENSE for license information.
//

private struct FontStyleInlineModifier: InlineContentModifier {
    var style: FontStyle
    func body(content: Content) -> some InlineContent {
        var modified = content
        if let sizeClass = style.sizeClass {
            modified.attributes.append(classes: sizeClass)
        }
        return modified
    }
}

public extension InlineContent {
    /// Adjusts the heading level of this text.
    /// - Parameter style: The new heading level.
    /// - Returns: A new `Text` instance with the updated font style.
    func font(_ style: Font.Style) -> some InlineContent {
        modifier(FontStyleInlineModifier(style: style))
    }
}
