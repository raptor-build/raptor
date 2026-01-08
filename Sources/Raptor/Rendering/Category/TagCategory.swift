//
// TagCategory.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

// A single tag applied to a post.
public struct TagCategory: Category {
    /// The name of the tag.
    public var name: String
    /// An array of content that has this tag.
    public var posts: [Post]
}
