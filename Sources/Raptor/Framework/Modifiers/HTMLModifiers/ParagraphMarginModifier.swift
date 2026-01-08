//
// ParagraphMarginModifier.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

/// A modifier that applies padding to dropdown menus via CSS variable.
private struct ParagraphMarginModifier: HTMLModifier {
    /// The amount of padding to apply.
    var padding: LengthUnit
    /// The edges where padding should be applied.
    var edges: Edge

    /// Applies the dropdown padding modification to the provided content.
    /// - Parameter content: The HTML content to modify.
    /// - Returns: The content with dropdown padding CSS variable applied.
    func body(content: Content) -> some HTML {
        var modified = content
        let styles = edges.edgeSet(variablePrefix: "paragraph-margin", value: padding.css)
        modified.attributes.append(styles: styles)
        return modified
    }
}

public extension HTML {
    /// Applies paragraph margin using a multiplier relative to the current font size.
    /// - Parameter amount: The margin multiplier. Defaults to `1.0`.
    /// - Returns: A modified copy of the element with paragraph margin applied.
    func paragraphMargin(_ amount: Double = 1.0) -> some HTML {
        modifier(ParagraphMarginModifier(padding: .em(amount), edges: .all))
    }

    /// Applies paragraph margin using a multiplier relative to the current font size.
    /// - Parameters:
    ///   - edges: The edges where the margin should be applied.
    ///   - amount: The margin multiplier. Defaults to `1.0`.
    /// - Returns: A modified copy of the element with paragraph margin applied.
    func paragraphMargin(_ edges: Edge, _ amount: Double = 1.0) -> some HTML {
        modifier(ParagraphMarginModifier(padding: .em(amount), edges: edges))
    }
}
