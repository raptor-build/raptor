//
// AllTagsCategory.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

// All tags applied to the posts of this site.
public struct AllTagsCategory: Category {
    /// The name of the category, which defaults to "All Tags".
    public var name = "All Tags"
    /// All of the posts that have a tag.
    public var posts: [Post]
}
