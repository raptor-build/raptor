//
// LineSpacingInlineModifier.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

/// A modifier that applies line spacing to inline elements.
private struct LineSpacingInlineModifier: InlineContentModifier {
    /// The line spacing configuration to apply.
    var spacing: Double

    /// Applies the line spacing configuration to the provided content.
    /// - Parameter content: The content to modify.
    /// - Returns: The modified inline element with line spacing applied.
    func body(content: Content) -> some InlineContent {
        var modified = content
        let spacing = spacing.formatted(.nonLocalizedDecimal)
        modified.attributes.append(styles: .lineHeight(.custom(String(spacing))))
        return modified
    }
}

public extension InlineContent {
    /// Sets the line height of the element using a custom value.
    /// - Parameter spacing: The line height multiplier to use.
    /// - Returns: The modified InlineElement element.
    func lineSpacing(_ spacing: Double) -> some InlineContent {
        modifier(LineSpacingInlineModifier(spacing: spacing))
    }
}
