//
//  Document.swift
//  Raptor
//  https://raptor.build
//  See LICENSE for license information.
//

import Testing
@testable import Raptor

@Suite("Document Tests")
struct DocumentTests {
    @Test("Starts with <!doctype html>")
    func containsDoctype() {
        let doc = PlainDocument {
            Main()
        }

        let output = withTestRenderingEnvironment {
            doc.render().string
        }

        #expect(output.hasPrefix("<!doctype html>"))
    }

    @Test("Renders html and body tags")
    func rendersHtmlAndBody() {
        let doc = PlainDocument {
            Main {
                Text("Content")
            }
        }

        let output = withTestRenderingEnvironment {
            doc.render().string
        }

        #expect(output.htmlTagWithCloseTag("html") != nil)
        #expect(output.htmlTagWithCloseTag("body") != nil)
    }

    @Test("Applies lang attribute")
    func appliesLangAttribute() throws {
        let doc = PlainDocument {
            Main()
        }

        let output = withTestRenderingEnvironment {
            doc.render().string
        }

        let html = try #require(output.htmlTagWithCloseTag("html"))
        #expect(html.attributes.htmlAttribute(named: "lang") == "en")
    }

    @Test("Renders scripts")
    func rendersScripts() {
        let doc = PlainDocument {
            Main()
        }

        let output = withTestRenderingEnvironment {
            doc.render().string
        }

        #expect(output.contains("raptor-core.js"))
    }

    @Test("Renders banner and navigation in header")
    func rendersHeaderRegions() {
        let doc = PlainDocument {
            Banner {
                Text("Banner")
            }

            Navigation {
                Text("Nav")
            }

            Main {
                Text("Content")
            }
        }

        let output = withTestRenderingEnvironment {
            doc.render().string
        }

        #expect(output.contains("<header"))
        #expect(output.contains("Banner"))
        #expect(output.contains("Nav"))
    }

    @Test("Only first region of each type is rendered")
    func rendersOnlyFirstRegion() {
        let doc = PlainDocument {
            Main { Text("First") }
            Main { Text("Second") }
        }

        let output = withTestRenderingEnvironment {
            doc.render().string
        }

        #expect(output.contains("First"))
        #expect(!output.contains("Second"))
    }

    @Test("Footer renders after main")
    func footerRendersAfterMain() throws {
        let doc = PlainDocument {
            Main { Text("Main") }
            Footer { Text("Footer") }
        }

        let output = withTestRenderingEnvironment {
            doc.render().string
        }

        func index(of substring: String, in string: String) throws -> String.Index {
            try #require(string.range(of: substring)).lowerBound
        }

        let mainIndex = try index(of: "Main", in: output)
        let footerIndex = try index(of: "Footer", in: output)

        #expect(footerIndex > mainIndex)

        #expect(footerIndex > mainIndex)
    }
}
