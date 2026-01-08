//
// VariadicInlineContent.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

/// A type that applies transformations to its subviews
/// during rendering.
protocol VariadicInlineContent {
    /// The subviews of the element's content.
    var subviews: InlineSubviewCollection { get }
}
