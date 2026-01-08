//
// Script.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

import Testing

@testable import Raptor

/// Tests for the `Script` element.
@Suite("Script Tests")
struct ScriptTests {
    private typealias SendableSite = Site & Sendable
    private static let sites: [any SendableSite] = [TestSite(), TestSubsite()]

    @Test("Code", arguments: Self.sites)
    private func code(for site: any SendableSite) {
        let element = Script(code: "javascript code")
        let output = withTestRenderingEnvironment {
            element.render().string
        }

        #expect(output == """
        <script>
        javascript code
        </script>
        """)
    }

    @Test("Local File", arguments: ["/code.js"], Self.sites)
    private func file(scriptFile: String, site: any SendableSite) {
        withTestRenderingEnvironment { context in
            let element = Script(file: scriptFile)
            let output = element.render().string

            let expectedPath = context.path(for: URL(string: scriptFile)!)
            #expect(output == "<script src=\"\(expectedPath)\"></script>")
        }
    }

    @Test("Remote File", arguments: ["https://example.com"], Self.sites)
    private func file(remoteScript: String, site: any SendableSite) {
        withTestRenderingEnvironment { context in
            let element = Script(file: remoteScript)
            let output = element.render().string

            let expectedPath = context.path(for: URL(string: remoteScript)!)
            #expect(output == "<script src=\"\(expectedPath)\"></script>")
        }
    }

    @Test("Attributes", arguments: ["/code.js"], Self.sites)
    private func attributes(scriptFile: String, site: any Sendable) {
        withTestRenderingEnvironment { context in
            let element = Script(file: scriptFile)
                .data("key", "value")
                .customAttribute(name: "custom", value: "part")
            let output = element.markupString()

            let expectedPath = context.path(for: URL(string: scriptFile)!)
            #expect(output == "<script custom=\"part\" src=\"\(expectedPath)\" data-key=\"value\"></script>")
        }
    }
}
