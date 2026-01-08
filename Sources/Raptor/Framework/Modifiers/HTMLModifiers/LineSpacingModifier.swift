//
// LineSpacingModifier.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

/// A modifier that applies line spacing to HTML content.
private struct LineSpacingModifier: HTMLModifier {
    /// The line spacing amount to apply.
    var spacing: Double

    /// Creates the modified HTML content with the specified line spacing.
    /// - Parameter content: The HTML content to modify.
    /// - Returns: HTML content with applied line spacing.
    func body(content: Content) -> some HTML {
        var modified = content
        let spacing = spacing.formatted(.nonLocalizedDecimal)
        modified.attributes.append(styles: .lineHeight(.custom(String(spacing))))
        return modified
    }
}

public extension HTML {
    /// Sets the line height of the element using a custom value.
    /// - Parameter spacing: The line height multiplier to use.
    /// - Returns: The modified HTML element.
    func lineSpacing(_ spacing: Double) -> some HTML {
        modifier(LineSpacingModifier(spacing: spacing))
    }
}

public extension StyleConfiguration {
    /// Sets the line height of the element using a custom value.
    /// - Parameter height: The line height multiplier to use
    /// - Returns: The modified HTML element
    func lineSpacing(_ spacing: Double) -> Self {
        let spacing = spacing.formatted(.nonLocalizedDecimal)
        return self.style(.lineHeight(.custom(String(spacing))))
    }
}
