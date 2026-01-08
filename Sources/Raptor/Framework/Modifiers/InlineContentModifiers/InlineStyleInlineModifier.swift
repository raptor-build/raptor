//
// InlineStyleInlineModifier.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

private struct InlineStyleInlineModifier: InlineContentModifier {
    var styles: [Property]
    func body(content: Content) -> some InlineContent {
        var content = content
        content.attributes.append(styles: styles)
        return content
    }
}

public extension InlineContent {
    /// Adds an inline style to the element.
    /// - Parameters:
    ///   - property: The CSS property.
    ///   - value: The value.
    /// - Returns: The modified `InlineElement` element
    func style(_ property: Property) -> some InlineContent {
        modifier(InlineStyleInlineModifier(styles: [property]))
    }
}

extension InlineContent {
    /// Adds inline styles to the element.
    /// - Parameter values: Variable number of `InlineStyle` objects
    /// - Returns: The modified `InlineElement` element
    func style(_ values: Property?...) -> some InlineContent {
        let styles = values.compactMap(\.self)
        return modifier(InlineStyleInlineModifier(styles: styles))
    }

    /// Adds inline styles to the element.
    /// - Parameter styles: An array of `InlineStyle` objects
    /// - Returns: The modified `InlineElement` element
    func style(_ styles: [Property]) -> some InlineContent {
        modifier(InlineStyleInlineModifier(styles: styles))
    }
}
