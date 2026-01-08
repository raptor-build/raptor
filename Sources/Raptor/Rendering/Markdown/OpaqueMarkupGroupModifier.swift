//
// MarkupEscapedModifier.swift
// Raptor Build
// https://raptor.build
// See LICENSE for license information.
//

public extension HTML {
    /// Marks this element’s rendered output as opaque markup.
    ///
    /// When applied, the element’s output is injected verbatim into post
    /// content and is not interpreted, escaped, or transformed by the
    /// active markup processor.
    func opaqueMarkupGroup() -> some HTML {
        BuildContext.current.widgetIsRawHTML = true
        return self
    }
}
