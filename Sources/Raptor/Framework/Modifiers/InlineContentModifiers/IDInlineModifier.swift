//
// IDInlineModifier.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

private struct IDInlineModifier: InlineContentModifier {
    var id: String
    func body(content: Content) -> some InlineContent {
        var content = content
        guard !id.isEmpty else { return content }
        content.attributes.id = id
        return content
    }
}

public extension InlineContent {
    /// Sets the `HTML` id attribute of the element.
    /// - Parameter id: The HTML ID value to set
    /// - Returns: A modified copy of the element with the HTML ID added
    func id(_ id: String) -> some InlineContent {
        modifier(IDInlineModifier(id: id))
    }
}
