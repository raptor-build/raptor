//
// TestSitePublisher.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

import Foundation
import Raptor

/// A test publisher for ``TestSite``.
///
/// It helps to run `TestSite/publish` with a correct path of the file that triggered the build.
struct TestSitePublisher {
    var site: any Site = TestSite()

    mutating func publish() async throws {
        try await site.publish()
    }

    func loadContent() throws -> [Post] {
        let packageDirectory = try URL.packageDirectory(from: #filePath)
        let sourceDirectory = packageDirectory

        let contentLoader = ContentLoader(
            processor: MarkdownToHTML(),
            locales: [.automatic],
            widgets: [])

        let allContent = try contentLoader.load(from: sourceDirectory)
        return allContent
    }
}
