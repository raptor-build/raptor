//
// TestSubsite.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

import Raptor

/// An example site used in tests.
struct TestSubsite: Site, @unchecked Sendable {
    var name = "My Test Subsite"
    var titleSuffix = " - My Test Subsite"
    var url = URL(static: "https://www.example.com/subsite")

    var homePage = TestSubsitePage()
    var layout = EmptyLayout()
}

/// An example page used in tests.
struct TestSubsitePage: Page, @unchecked Sendable {
    var title = "Subsite Home"

    var body: some HTML {
        Text("Example subsite text")
    }
}
