//
// SubviewsProvider.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

/// An `HTML` element that has `PackHTML` as its root view.
protocol SubviewProvider {
    /// The collection of subviews contained within this provider.
    var subviews: SubviewCollection { get }
}
