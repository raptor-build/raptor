//
// HintInlineModifier.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

/// Modifier that adds hint functionality to inline elements.
private struct HintInlineModifier: InlineContentModifier {
    /// The hint string to apply.
    var hint: String

    func body(content: Content) -> some InlineContent {
        var modified = content
        modified.attributes.append(customAttributes: .init(name: "title", value: hint))
        return modified
    }
}

public extension InlineContent {
    /// Creates a plain-text tooltip for this element.
    /// - Parameter text: The text to show in the tooltip.
    /// - Returns: A modified copy of the element with tooltip attached
    func help(_ text: String) -> some InlineContent {
        modifier(HintInlineModifier(hint: text))
    }
}
