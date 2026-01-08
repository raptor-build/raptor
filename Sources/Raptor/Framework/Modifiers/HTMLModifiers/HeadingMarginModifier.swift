//
// HeadingMarginModifier.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

/// A modifier that applies padding to dropdown menus via CSS variable.
private struct HeadingMarginModifier: HTMLModifier {
    /// The amount of padding to apply.
    var padding: LengthUnit
    /// The edges where padding should be applied.
    var edges: Edge

    /// Applies the dropdown padding modification to the provided content.
    /// - Parameter content: The HTML content to modify.
    /// - Returns: The content with dropdown padding CSS variable applied.
    func body(content: Content) -> some HTML {
        var modified = content
        let styles = edges.edgeSet(variablePrefix: "heading-margin", value: padding.css)
        modified.attributes.append(styles: styles)
        return modified
    }
}

public extension HTML {
    /// Applies padding to the dropdown menu. Defaults to 20 pixels.
    /// - Parameter length: The amount of padding to apply, specified in pixels.
    /// - Returns: A copy of the current element with the new dropdown padding applied.
    func headingMargin(_ length: Int = 20) -> some HTML {
        modifier(HeadingMarginModifier(padding: .px(length), edges: .all))
    }

    /// Applies padding to the dropdown menu. Defaults to 20 pixels.
    /// - Parameter length: The amount of padding to apply, specified in
    /// units of your choosing.
    /// - Returns: A copy of the current element with the new dropdown padding applied.
    func headingMargin(_ length: LengthUnit) -> some HTML {
        modifier(HeadingMarginModifier(padding: length, edges: .all))
    }

    /// Applies padding to selected sides of the dropdown menu. Defaults to 20 pixels.
    /// - Parameters:
    ///   - edges: The edges where this padding should be applied.
    ///   - length: The amount of padding to apply, specified in pixels.
    /// - Returns: A copy of the current element with the new dropdown padding applied.
    func headingMargin(_ edges: Edge, _ length: Int = 20) -> some HTML {
        modifier(HeadingMarginModifier(padding: .px(length), edges: edges))
    }

    /// Applies padding to selected sides of the dropdown menu. Defaults to 20 pixels.
    /// - Parameters:
    ///   - edges: The edges where this padding should be applied.
    ///   - length: The amount of padding to apply, specified in
    /// units of your choosing.
    /// - Returns: A copy of the current element with the new dropdown padding applied.
    func headingMargin(_ edges: Edge, _ length: LengthUnit) -> some HTML {
        modifier(HeadingMarginModifier(padding: length, edges: edges))
    }
}
