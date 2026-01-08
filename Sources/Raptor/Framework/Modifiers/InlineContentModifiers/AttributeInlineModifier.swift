//
// AttributeInlineModifier.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

private struct InlineAttributeModifier: InlineContentModifier {
    var attribute: Attribute?
    func body(content: Content) -> some InlineContent {
        var content = content
        guard let attribute else { return content }
        content.attributes.append(customAttributes: attribute)
        return content
    }
}

public extension InlineContent {
    /// Adds a custom attribute to the element.
    /// - Parameters:
    ///   - name: The name of the attribute
    ///   - value: The value of the attribute
    /// - Returns: The modified element
    func attribute(_ name: String, _ value: String) -> some InlineContent {
        modifier(InlineAttributeModifier(attribute: .init(name: name, value: value)))
    }

    /// Adds a custom boolean attribute to the element.
    /// - Parameter name: The name of the attribute
    /// - Returns: The modified element
    func attribute(_ name: String) -> some InlineContent {
        modifier(InlineAttributeModifier(attribute: .init(name)))
    }
}

extension InlineContent {
    /// Adds a custom attribute to the element.
    /// - Parameters:
    ///   - name: The name of the custom attribute
    ///   - value: The value of the custom attribute
    /// - Returns: The modified `HTML` element
    func customAttribute(name: String, value: String) -> some InlineContent {
        modifier(InlineAttributeModifier(attribute: .init(name: name, value: value)))
    }

    /// Adds a custom attribute to the element.
    /// - Parameters:
    ///   - name: The name of the custom attribute
    ///   - value: The value of the custom attribute
    /// - Returns: The modified `HTML` element
    func customAttribute(_ attribute: Attribute?) -> some InlineContent {
        modifier(InlineAttributeModifier(attribute: attribute))
    }
}
