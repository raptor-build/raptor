//
// PostCollection.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

/// A lightweight random-access collection of `Post` values.
public struct PostCollection: RandomAccessCollection, Sendable {
    public typealias Element = Post
    public typealias Index = Int

    /// Internal storage of all posts.
    private let all: [Post]

    /// Creates a new collection of posts.
    /// - Parameter content: The posts to wrap.
    init(content: [Post]) {
        self.all = content
    }

    /// The position of the first element.
    nonisolated public var startIndex: Int { all.startIndex }

    /// The position one greater than the last element.
    nonisolated public var endIndex: Int { all.endIndex }

    /// Returns the element at the given position.
    nonisolated public subscript(position: Int) -> Post { all[position] }

    /// The number of posts in the collection.
    nonisolated public var count: Int { all.count }

    /// Returns all posts that match the specified type.
    /// - Parameter type: The type identifier to filter by.
    /// - Returns: A new array containing posts with the matching type.
    public func typed(_ type: String) -> [Post] {
        all.filter { $0.type == type }
    }

    /// Returns all posts tagged with the specified tag.
    /// - Parameter tag: The tag name to match.
    /// - Returns: A new array containing posts that include the tag.
    public func tagged(_ tag: String) -> [Post] {
        all.filter { $0.tags?.contains(where: { $0.name == tag }) == true }
    }
}
