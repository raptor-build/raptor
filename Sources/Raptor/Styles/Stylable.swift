//
// Stylable.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

/// A type that supports applying inline style properties.
public protocol Stylable {
    /// Returns a copy of the receiver with the given style property applied.
    /// - Parameter style: The inline style property to apply.
    /// - Returns: A new instance with the style applied.
    func style(_ style: Property) -> Self
}

extension Stylable {
    /// Returns a copy of the receiver with multiple style properties applied in order.
    /// - Parameter styles: The inline style properties to apply.
    /// - Returns: A new instance with all styles applied.
    func style(_ styles: [Property]) -> Self {
        styles.reduce(self) { result, style in
            result.style(style)
        }
    }
}
