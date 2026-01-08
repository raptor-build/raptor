//
// TestSite.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

import Foundation
import Raptor

/// An example site used in tests.
struct TestSite: Site, @unchecked Sendable {
    var name = "My Test Site"
    var titleSuffix = " - My Test Site"
    var url = URL(static: "https://www.example.com")
    var locales: [Locale] = [.english]

    var homePage = TestPage()
    var layout = EmptyLayout()

    var feedConfiguration = FeedConfiguration(
        mode: .descriptionOnly,
        contentCount: 20,
        image: .init(url: "path/to/image.png", width: 100, height: 100)
    )

    var postPages: [any PostPage] = [
        TestStory()
    ]

    var themes: [any Theme] {
        TestTheme1()
        TestTheme2()
    }

    init() {}

    init(locale: Locale) {
        self.locales = [locale]
    }
}

/// A lightweight test theme used to validate theme-driven effects.
private struct TestTheme1: Theme {
    func theme(site: Content, colorScheme: ColorScheme) -> Content {
        site
    }
}

/// A lightweight test theme used to validate theme-driven effects.
private struct TestTheme2: Theme {
    func theme(site: Content, colorScheme: ColorScheme) -> Content {
        site
            .foregroundStyle(.red)
    }
}
