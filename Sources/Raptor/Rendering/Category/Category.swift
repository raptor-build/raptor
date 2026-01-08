//
// Category.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

/// The category by which posts on your site can be grouped.
public protocol Category: CustomStringConvertible, Sendable {
    /// The name of the category.
    var name: String { get }
    /// An array of posts that belongs to this category.
    var posts: [Post] { get }
}

public extension Category {
    var description: String {
        name
    }
}
