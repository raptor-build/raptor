//
// DataInlineModifier.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

private struct DataInlineModifier: InlineContentModifier {
    var name: String
    var value: String
    func body(content: Content) -> some InlineContent {
        var content = content
        content.attributes.data.append(.init(name: name, value: value))
        return content
    }
}

public extension InlineContent {
    /// Adds a data attribute to the element.
    /// - Parameters:
    ///   - name: The name of the data attribute
    ///   - value: The value of the data attribute
    /// - Returns: The modified `HTML` element
    func data(_ name: String, _ value: String) -> some InlineContent {
        modifier(DataInlineModifier(name: name, value: value))
    }
}
