//
//  PostProcessor.swift
//  Raptor
//  https://raptor.build
//  See LICENSE for license information.
//

import Foundation
import Testing

@testable import Raptor

/// Tests for `PostProcessor`.
@Suite("PostProcessor Tests")
struct PostProcessorTests {
    @Test(
        "Markdown headings from string",
        arguments: ["# Heading 1", "## Heading 2", "### Heading 3", "# Heading with a #hashtag"]
    )
    func convertMarkdownHeadingsToHTML(markdown: String) throws {
        var processor = MarkdownToHTML()
        processor.removeTitleFromBody = false
        let processed = processor.process(markdown)

        let expectedTag = "h\(numberOfHashtags(in: markdown))"
        let expectedContent = String(markdown.drop(while: { $0 == "#" }))
            .trimmingCharacters(in: .whitespacesAndNewlines)
        #expect(processed.body == "<\(expectedTag)>\(expectedContent)</\(expectedTag)>")
    }

    @Test("Markdown heading remove title from body")
    func removeMarkdownTitleFromBody() throws {
        var processor = MarkdownToHTML()
        let processed = processor.process("# Test Heading\n\nTest content")
        #expect(processed.body == "<p>Test content</p>")
    }

    @Test("Markdown paragraphs from string", arguments: ["Paragraph one\n\nParagraph two"])
    func convertMarkdownParagraphsToHTML(markdown: String) throws {
        var processor = MarkdownToHTML()
        processor.removeTitleFromBody = false
        let processed = processor.process(markdown)

        let paragraphs = markdown.split(separator: "\n\n")
        let expectedHTML = paragraphs
            .map {
                "<p>\($0)</p>"
            }
            .joined()
        #expect(processed.body == "\(expectedHTML)")
    }

    @Test("Markdown block quotes from string", arguments: ["> Here is an example quote"])
    func convertMarkdownBlockQuotesToHTML(markdown: String) throws {
        var processor = MarkdownToHTML()
        let processed = processor.process(markdown)

        #expect(processed.body == "<blockquote><p>Here is an example quote</p></blockquote>")
    }

    @Test("Markdown image from string", arguments: ["Here is an ![Image description](path/to/example/image.jpg)"])
    func convertMarkdownImageToHTML(markdown: String) throws {
        var processor = MarkdownToHTML()
        processor.removeTitleFromBody = false
        let processed = processor.process(markdown)

        let expectedImageHTML = """
        <img src=\"path/to/example/image.jpg\" alt=\"Image description\" class=\"img-resizable\">
        """
        #expect(processed.body == "<p>Here is an \(expectedImageHTML)</p>")
    }

    @Test("Markdown code block from string", arguments: ["Here is some `var code = \"great\"`"])
    func convertMarkdownCodeBlockToHTML(markdown: String) throws {
        var processor = MarkdownToHTML()
        processor.removeTitleFromBody = false
        let processed = processor.process(markdown)
        #expect(processed.body == "<p>Here is some <code>var code = \"great\"</code></p>")
    }

    @Test("Markdown emphasis from string", arguments: ["Here is some *emphasized* text"])
    func convertMarkdownEmphasisToHTML(markdown: String) throws {
        var processor = MarkdownToHTML()
        processor.removeTitleFromBody = false
        let processed = processor.process(markdown)
        #expect(processed.body == "<p>Here is some <em>emphasized</em> text</p>")
    }

    @Test("Markdown link from string", arguments: ["Here is a [link](https://example.com)"])
    func convertMarkdownLinkToHTML(markdown: String) throws {
        var processor = MarkdownToHTML()
        processor.removeTitleFromBody = false
        let processed = processor.process(markdown)
        #expect(processed.body == "<p>Here is a <a href=\"https://example.com\">link</a></p>")
    }

    @Test("Markdown list from string")
    func convertMarkdownListToHTML() throws {
        let markdown = """
        - Item 1
        - Item 2
        """
        var processor = MarkdownToHTML()
        processor.removeTitleFromBody = false
        let processed = processor.process(markdown)

        #expect(processed.body == "<ul><li>Item 1</li><li>Item 2</li></ul>")
    }

    @Test("Markdown ordered list from string")
    func convertMarkdownOrderedListToHTML() throws {
        let markdown = """
        1. Item 1
        2. Item 2
        """
        var processor = MarkdownToHTML()
        processor.removeTitleFromBody = false
        let processed = processor.process(markdown)

        #expect(processed.body == "<ol><li>Item 1</li><li>Item 2</li></ol>")
    }

    @Test("Markdown strikethrough from string")
    func convertMarkdownStrikethroughToHTML() throws {
        let markdown = "Example text with some of it ~crossed out~"
        var processor = MarkdownToHTML()
        processor.removeTitleFromBody = false
        let processed = processor.process(markdown)
        #expect(processed.body == "<p>Example text with some of it <s>crossed out</s></p>")
    }

    @Test("Markdown strong from string")
    func convertMarkdownStrongToHTML() throws {
        let markdown = "Example of **strong** text"
        var processor = MarkdownToHTML()
        processor.removeTitleFromBody = false
        let processed = processor.process(markdown)

        #expect(processed.body == "<p>Example of <strong>strong</strong> text</p>")
    }

    @Test("Markdown table from string")
    func convertMarkdownTableToHTML() throws {
        let markdown = """
        | Title 1 | Title 2 |
        | --- | --- |
        | Content 1 | Content 2|
        """
        var processor = MarkdownToHTML()
        processor.removeTitleFromBody = false
        let processed = processor.process(markdown)

        #expect(processed.body == """
        <table>\
        <thead>\
        <th scope="col">Title 1</th>\
        <th scope="col">Title 2</th>\
        </thead>\
        <tbody>\
        <tr>\
        <td>Content 1</td>\
        <td>Content 2</td>\
        </tr>\
        </tbody>\
        </table>
        """)
    }

    @Test("Markdown thematic break from string")
    func convertMarkdownThematicBreakToHTML() throws {
        let markdown = """
        Text above

        ---

        Text below
        """
        var processor = MarkdownToHTML()
        processor.removeTitleFromBody = false
        let processed = processor.process(markdown)

        #expect(processed.body == "<p>Text above</p><hr /><p>Text below</p>")
    }
}

extension PostProcessorTests {
    private func numberOfHashtags(in markdown: String) -> Int {
        return markdown.prefix(while: { $0 == "#" }).count
    }
}
