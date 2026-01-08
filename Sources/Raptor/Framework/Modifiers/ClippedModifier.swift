//
// Clipped.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

/// A modifier that clips an element to its bounds.
private struct ClippedModifier: HTMLModifier {
    func body(content: Content) -> some HTML {
        var modified = content
        modified.attributes.append(styles: .overflow(.hidden))
        return modified
    }
}

public extension HTML {
    /// Applies CSS `overflow:hidden` to clip the element's content to its bounds.
    /// - Returns: A modified copy of the element with clipping applied
    func clipped() -> some HTML {
        modifier(ClippedModifier())
    }
}
