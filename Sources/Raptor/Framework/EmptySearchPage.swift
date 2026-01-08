//
// EmptySearchPage.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

/// A default error page that does nothing.
public struct EmptySearchPage: SearchPage {
    public var body: some HTML {
        EmptyHTML()
    }
}
