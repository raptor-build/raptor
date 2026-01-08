//
// SearchResultCollection.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

/// The results of a search.
public struct SearchResultCollection: Sendable {
    private var results: [SearchResult] = []

    init(_ elements: [SearchResult]) {
        self.results = elements
    }

    init() {}

    /// Whether search results are available.
   public var isEmpty: Bool {
        results.isEmpty
    }

    /// Returns an array containing the results of mapping the given closure over the collection's elements.
    /// - Parameter transform: A mapping closure that accepts an element of this collection as its parameter
    ///   and returns a transformed value of the same or of a different type.
    /// - Returns: An array containing the transformed elements of this collection.
    func map<T>(_ transform: (SearchResult) -> T) -> [T] {
        results.map(transform)
    }
}
