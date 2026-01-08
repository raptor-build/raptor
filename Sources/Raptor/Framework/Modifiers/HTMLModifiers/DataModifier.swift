//
// DataModifier.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

private struct DataModifier: HTMLModifier {
    var attribute: Attribute?
    func body(content: Content) -> some HTML {
        guard let attribute else { return content }
        var modified = content
        modified.attributes.append(dataAttributes: attribute)
        return modified
    }
}

public extension HTML {
    /// Adds a data attribute to the element.
    /// - Parameters:
    ///   - name: The name of the data attribute
    ///   - value: The value of the data attribute
    /// - Returns: The modified `HTML` element
    func data(_ name: String, _ value: String) -> some HTML {
        modifier(DataModifier(attribute: .init(name: name, value: value)))
    }
}

extension HTML {
    /// Adds a data attribute to the element.
    /// - Parameter name: The name of the data attribute
    /// - Returns: The modified `HTML` element
    func data(_ name: String?) -> some HTML {
        modifier(DataModifier(attribute: .init(name)))
    }
}

private extension Attribute {
    init?(_ name: String?) {
        guard let name else { return nil }
        self.init(name)
    }
}
