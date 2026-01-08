//
// DefaultErrorPage.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

/// A default error page that does nothing.
struct DefaultErrorPage: ErrorPage {
    let error: any HTTPError
    var body: some HTML {
        Text(error.title)
            .font(.title1)
        Text(error.description)
    }
}
