//
// ForegroundStyleInlineModifier.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

/// A modifier that applies foreground styling to inline elements.
private struct ForegroundStyleInlineModifier: InlineContentModifier {
    /// The foreground style to apply.
    var style: ForegroundStyleType

    /// Creates the modified inline element with the specified foreground style.
    /// - Parameter content: The content to modify.
    /// - Returns: The modified inline element.
    func body(content: Content) -> some InlineContent {
        var modified = content
        switch style {
        case .gradient(let gradient):
            modified.attributes.append(styles: gradient.styles)
        case .color(let color):
            modified.attributes.append(styles: .color(color.html))
        }
        return modified
    }
}

public extension InlineContent {
    /// Applies a foreground color to the current element.
    /// - Parameter color: The style to apply, specified as a `Color` object.
    /// - Returns: The current element with the updated color applied.
    func foregroundStyle(_ color: Color) -> some InlineContent {
        modifier(ForegroundStyleInlineModifier(style: .color(color)))
    }

    /// Applies a foreground color to the current element.
    /// - Parameter gradient: The style to apply, specified as a `Gradient` object.
    /// - Returns: The current element with the updated color applied.
    func foregroundStyle(_ gradient: Gradient) -> some InlineContent {
        modifier(ForegroundStyleInlineModifier(style: .gradient(gradient)))
    }
}
