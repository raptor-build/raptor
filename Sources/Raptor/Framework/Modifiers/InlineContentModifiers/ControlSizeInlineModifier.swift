//
// ControlSizeInlineModifier.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

/// A modifier that applies size styling to control elements
private struct ControlSizeInlineModifier: InlineContentModifier {
    let size: ControlSize

    func body(content: Content) -> some InlineContent {
        var modified = content
        modified.attributes.append(classes: size.cssClass)
        return modified
    }
}

public extension InlineContent {
    /// Applies a control size to this element
    /// - Parameter size: The control size to apply
    /// - Returns: The element with control size applied
    func controlSize(_ size: ControlSize) -> some InlineContent {
        modifier(ControlSizeInlineModifier(size: size))
    }
}
