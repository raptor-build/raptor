//
// InlineSubviewsProvider.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

/// An `InlineElement` that has `PackHTML` as its root view.
protocol InlineSubviewProvider {
    /// The collection of subviews contained within this provider.
    var subviews: InlineSubviewCollection { get }
}
