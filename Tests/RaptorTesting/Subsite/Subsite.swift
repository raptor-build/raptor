//
// Subsite.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

import Foundation
import Testing

@testable import Raptor

/// Tests for subsites.
@Suite("Subsite Tests")
struct SubsiteTests {
    // MARK: - Image

    @Test("Image Test", arguments: ["/images/example.jpg"], ["Example image"])
    func named(path: String, description: String) {
        let element = Image(path, description: description)
        withTestRenderingEnvironment { context in
            let output = element.markupString()
            let path = context.path(for: URL(string: path)!)
            #expect(output == "<img src=\"\(path)\" alt=\"Example image\" />")
        }
    }

    // MARK: - PlainDocument

    @Test("PlainDocument renders body and scripts")
    func plainDocument_renders_body_and_scripts() {
        let doc = PlainDocument {
            Main()
        }

        let output = withTestRenderingEnvironment {
            doc.render().string
        }

        let scriptPath = "/js/raptor-core.js"

        #expect(output.contains("<body"))
        #expect(output.contains("<main>"))
        #expect(output.contains("<script defer src=\"\(scriptPath)\"></script>"))
    }

    // MARK: - Script

    @Test("Script File Test", arguments: ["/code.js"])
    func file(scriptFile: String) {
        let element = Script(file: scriptFile)
        withTestRenderingEnvironment { context in
            let output = element.render().string
            let expectedPath = context.path(for: URL(string: scriptFile)!)
            #expect(output == "<script src=\"\(expectedPath)\"></script>")
        }
    }

    @Test("Attributes Test", arguments: ["/code.js"])
    func attributes(scriptFile: String) {
        let element = Script(file: scriptFile)
            .data("key", "value")
            .customAttribute(name: "custom", value: "part")

        withTestRenderingEnvironment { context in
            let output = element.markupString()
            let expectedPath = context.path(for: URL(string: scriptFile)!)
            #expect(output == "<script custom=\"part\" src=\"\(expectedPath)\" data-key=\"value\"></script>")
        }
    }

    // MARK: - Link

    @Test("String Target Test", arguments: ["/"], ["Go Home"])
    func target(for target: String, description: String) {
        let element = Link(description, destination: target)
        withTestRenderingEnvironment { context in
            let output = element.markupString()
            let expectedPath = context.path(for: URL(string: target)!)
            #expect(output == "<a href=\"\(expectedPath)\">\(description)</a>")
        }
    }

    @Test("Page Target Test")
    func target() {
        let page = TestSubsitePage()
        let element = Link("This is a test", destination: page)
        let output = withTestRenderingEnvironment {
            element.markupString()
        }
        #expect(output == "<a href=\"\(page.path)\">This is a test</a>")
    }

    @Test("Page Content Test")
    func content() {
        let page = TestPage()
        let element = LinkGroup(destination: page) {
            "MORE "
            Text("CONTENT")
        }
        let output = withTestRenderingEnvironment {
            element.markupString()
        }
        #expect(output == "<a href=\"\(page.path)\" class=\"link-plain d-inline-block\">MORE <p>CONTENT</p></a>")
    }
}
