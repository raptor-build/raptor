//
// EmptyErrorPage.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

/// A default error page that does nothing.
public struct EmptyErrorPage: ErrorPage {
    public var body: some HTML {
        EmptyHTML()
    }
}
