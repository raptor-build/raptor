//
// OpacityInlineModifier.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

/// A modifier that applies opacity styling to inline HTML elements.
private struct OpacityInlineModifier: InlineContentModifier {
    /// The opacity value to apply.
    var opacity: OpacityType

    func body(content: Content) -> some InlineContent {
        var modified = content
        let styles = OpacityModifier.styles(for: opacity)
        modified.attributes.append(styles: styles)
        return modified
    }
}

public extension InlineContent {
    /// Adjusts the opacity of an element.
    /// - Parameter value: A value between 0% (fully transparent) and 100% (fully opaque).
    /// - Returns: A modified copy of the element with opacity applied
    func opacity(_ value: Percentage) -> some InlineContent {
        modifier(OpacityInlineModifier(opacity: .percent(value)))
    }

    /// Adjusts the opacity of an element.
    /// - Parameter value: A value between 0 (fully transparent) and 1.0 (fully opaque).
    /// - Returns: A modified copy of the element with opacity applied
    func opacity(_ value: Double) -> some InlineContent {
        modifier(OpacityInlineModifier(opacity: .double(value)))
    }
}
