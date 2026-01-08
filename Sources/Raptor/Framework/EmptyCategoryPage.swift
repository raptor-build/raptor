//
// EmptyCategoryPage.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

/// A default category page that does nothing; used to disable category pages entirely.
public struct EmptyCategoryPage: CategoryPage {
    public var body: some HTML {
        EmptyHTML()
    }
}
