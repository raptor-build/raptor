//
// HintModifier.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

/// Modifier that adds hint functionality to HTML elements.
struct HintModifier: HTMLModifier {
    /// The hint string to apply.
    var hint: String

    func body(content: Content) -> some HTML {
        var modified = content
        modified.attributes.append(customAttributes: .init(name: "title", value: hint))
        return modified
    }
}

public extension HTML {
    /// Creates a plain-text tooltip for this element.
    /// - Parameter text: The text to show in the tooltip.
    /// - Returns: A modified copy of the element with tooltip attached
    func help(_ text: String) -> some HTML {
        modifier(HintModifier(hint: text))
    }
}
