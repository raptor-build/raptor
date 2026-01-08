//
// ControlSizeInlineModifier.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

private struct ControlSizeModifier: HTMLModifier {
    let size: ControlSize

    func body(content: Content) -> some HTML {
        var modified = content
        modified.attributes.append(classes: size.cssClass)
        return modified
    }
}

public extension HTML {
    /// Applies a control size to this element
    /// - Parameter size: The control size to apply
    /// - Returns: The element with control size applied
    func controlSize(_ size: ControlSize) -> some HTML {
        modifier(ControlSizeModifier(size: size))
    }
}
