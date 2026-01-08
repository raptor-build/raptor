//
// CoreAttributesInlineModifier.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

private struct CoreAttributesInlineModifier: InlineContentModifier {
    var attributes: CoreAttributes
    func body(content: Content) -> some InlineContent {
        var content = content
        content.attributes.merge(attributes)
        return content
    }
}

extension InlineContent {
    /// Merges a complete set of core attributes into this element.
    /// - Parameter attributes: The CoreAttributes to merge with existing attributes
    /// - Returns: The modified `HTML` element
    func attributes(_ attributes: CoreAttributes) -> some InlineContent {
        modifier(CoreAttributesInlineModifier(attributes: attributes))
    }
}
