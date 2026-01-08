//
// Main.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

import Testing
@testable import Raptor

@Suite("Main Tests")
struct MainTests {
    @Test("Main renders main element")
    func rendersMainElement() {
        withTestRenderingEnvironment {
            let main = Main {
                Text("Hello")
            }

            let output = main.render().string
            #expect(output.contains("<main"))
            #expect(output.contains("</main>"))
            #expect(output.contains("Hello"))
        }
    }

    @Test("standardHeadersDisabled preserves minimal document head")
    func standardHeadersDisabledKeepsBaselineHead() throws {
        let main = Main().standardHeadersDisabled()

        let head = withTestRenderingEnvironment {
            main.head.render().string
        }

        #expect(head.hasPrefix("<head>"))
        #expect(head.hasSuffix("</head>"))

        #expect(head.contains(#"<meta charset="utf-8""#))
        #expect(head.contains(#"name="viewport""#))
        #expect(head.contains(#"<title>"#))
        #expect(head.contains(#"/js/raptor-core.js"#))
    }

    @Test("Main head modifiers are applied")
    func headModifiersAreApplied() throws {
        let main = Main()
            .standardHeadersDisabled()
            .script("custom.js")
            .shareLinkTitle("Hello World")

        let headOutput = withTestRenderingEnvironment {
            main.head.render().string
        }

        #expect(headOutput.contains("custom.js"))
        #expect(headOutput.contains("Hello World"))
    }

    @Test("Main registers body attributes")
    func bodyAttributesAreRegistered() {
        let main = Main().data("test", "value")
        let attributes = main.bodyAttributes
        #expect(attributes.data.contains(where: { $0.name == "test" && $0.value == "value" }))
    }
}
