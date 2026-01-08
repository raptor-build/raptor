//
// TintModifier.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

/// A modifier that applies accent color tinting to elements and their children
private struct TintModifier: HTMLModifier {
    let accentColor: Color

    func body(content: Content) -> some HTML {
        var modified = content
        modified.attributes.append(styles: .variable("accent", value: accentColor.description))
        return modified
    }
}

public extension HTML {
    /// Applies an accent color tint to this element and its children
    /// - Parameter color: The accent color to use
    /// - Returns: The element with accent color applied
    func tint(_ color: Color) -> some HTML {
        modifier(TintModifier(accentColor: color))
    }
}
