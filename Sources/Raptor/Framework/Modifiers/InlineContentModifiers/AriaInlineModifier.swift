//
// AriaInlineModifier.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

private struct AriaInlineModifier: InlineContentModifier {
    var key: AriaType
    var value: String?
    func body(content: Content) -> some InlineContent {
        var content = content
        guard let value else { return content }
        content.attributes.aria.append(.init(name: key.rawValue, value: value))
        return content
    }
}

public extension InlineContent {
    /// Adds an ARIA attribute to the element.
    /// - Parameters:
    ///   - key: The ARIA attribute key
    ///   - value: The ARIA attribute value
    /// - Returns: The modified `HTML` element
    func aria(_ key: AriaType, _ value: String) -> some InlineContent {
        modifier(AriaInlineModifier(key: key, value: value))
    }

    /// Adds an ARIA attribute to the element.
    /// - Parameters:
    ///   - key: The ARIA attribute key
    ///   - value: The ARIA attribute value
    /// - Returns: The modified `InlineElement`
    func aria(_ key: AriaType, _ value: String?) -> some InlineContent {
        modifier(AriaInlineModifier(key: key, value: value))
    }
}
