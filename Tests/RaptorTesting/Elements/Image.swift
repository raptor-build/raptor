//
// Image.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

import Foundation
import Testing

@testable import Raptor

/// Tests for the `Image` element.
@Suite("Image Tests")
struct ImageTests {
    @Test("Local Image", arguments: ["/images/example.jpg"], ["Example image"])
    func named(file: String, description: String) {
        withTestRenderingEnvironment { context in
            let element = Image(file, description: description)
            let output = element.markupString()

            let expectedPath = context.path(for: URL(string: file)!)
            #expect(output == "<img src=\"\(expectedPath)\" alt=\"\(description)\" />")
        }
    }

    @Test("Remote Image", arguments: ["https://example.com"], ["Example image"])
    func named(url: String, description: String) {
        withTestRenderingEnvironment { context in
            let element = Image(url, description: description)
            let output = element.markupString()

            let expectedPath = context.path(for: URL(string: url)!)
            #expect(output == "<img src=\"\(expectedPath)\" alt=\"\(description)\" />")
        }
    }

    @Test("Icon Image", arguments: ["browser-safari"], ["Safari logo"])
    func icon(systemName: String, description: String) {
        let element = Image(systemName: systemName, description: description)
        let output = element.markupString()
        #expect(output.contains("<i alt=\"browser-safari\" class=\"bi-\(systemName)\">"))
        #expect(output.hasSuffix("</i>"))
    }
}
