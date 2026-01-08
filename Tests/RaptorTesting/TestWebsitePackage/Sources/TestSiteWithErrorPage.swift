//
// TestSiteWithErrorPage.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

import Foundation
import Raptor

/// A test site that shows an error page.
struct TestSiteWithErrorPage: Site {
    var name = "My Error Page Test Site"
    var titleSuffix = " - My Test Site"
    var url = URL(static: "https://www.example.com")
    var locales: [Locale] = [.english]

    var homePage = TestPage()
    var layout = EmptyLayout()

    var errorPage = TestErrorPage()

    var postPages: [any PostPage] = [
        TestStory()
    ]

    var pages: [any Page] = [
        TestPage()
    ]

    init() {}

    init(errorPage: ErrorPageType) {
        self.errorPage = errorPage
    }
}
