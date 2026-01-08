//
// EmptyCategory.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

/// Represents the absence of a category.
struct EmptyCategory: Category {
    var name: String { "" }
    var posts: [Post] { [] }
}
