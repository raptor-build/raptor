//
// VariadicHTML.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

/// A type that applies transformations to its subviews
/// during rendering.
protocol VariadicHTML {
    /// The subviews of the element's content.
    var subviews: SubviewCollection { get }
}
