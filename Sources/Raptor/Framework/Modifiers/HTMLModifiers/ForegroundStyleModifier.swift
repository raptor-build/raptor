//
// ForegroundStyleModifier.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

/// The type of style this contains.
enum ForegroundStyleType {
    case color(Color)
    case gradient(Gradient)
}

/// A modifier that applies foreground styling to HTML content.
private struct ForegroundStyleModifier: HTMLModifier {
    /// The foreground style to apply.
    var style: ForegroundStyleType

    /// Creates the modified HTML content with the specified foreground style.
    /// - Parameter content: The original HTML content to modify.
    /// - Returns: HTML content with the foreground style applied.
    func body(content: Content) -> some HTML {
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

public extension HTML {
    /// Applies a foreground color to the current element.
    /// - Parameter color: The style to apply, specified as a `Color` object.
    /// - Returns: The current element with the updated color applied.
    func foregroundStyle(_ color: Color) -> some HTML {
        modifier(ForegroundStyleModifier(style: .color(color)))
    }

    /// Applies a foreground color to the current element.
    /// - Parameter gradient: The style to apply, specified as a `Gradient` object.
    /// - Returns: The current element with the updated color applied.
    func foregroundStyle(_ gradient: Gradient) -> some HTML {
        modifier(ForegroundStyleModifier(style: .gradient(gradient)))
    }
}
