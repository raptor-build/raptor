//
// Text.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

import Testing

@testable import Raptor

/// Tests for the `Text` element.
@Suite("Text Tests")
struct TextTests {
    @Test("Simple String")
    func simpleString() {
        let element = Text("Hello")
        let output = element.markupString()
        #expect(output == "<p>Hello</p>")
    }

    @Test("Builder with Simple String")
    func test_simpleBuilderString() {
        let element = Text { "Hello" }
        let output = element.markupString()
        #expect(output == "<p>Hello</p>")
    }

    @Test("Builder with Complex String")
    func complexBuilderString() {
        let element = Text {
            "Hello, "
            InlineText("world")

            Strikethrough {
                " - "
                InlineText {
                    "this "
                    Underline("is")
                    " a"
                }
                " test!"
            }
        }

        let output = element.markupString()

        #expect(output == """
        <p>Hello, <span>world</span><s> - <span>this <u>is</u> a</span> test!</s></p>
        """)
    }

    @Test("Custom Font", arguments: Font.Style.allCases)
    func customFont(font: Font.Style) {
        let element = Text("Hello").font(font)
        let output = element.markupString()

        if FontStyle.classBasedStyles.contains(font), let sizeClass = font.sizeClass {
            // This applies a paragraph class rather than a different tag.
            #expect(output == "<p class=\"\(sizeClass)\">Hello</p>")
        } else {
            #expect(output == "<\(font.rawValue)>Hello</\(font.rawValue)>")
        }
    }

    @Test("Markdown")
    func markdown() {
        let element = Text(markdown: "*i*, **b**, and ***b&i***")
        let output = element.markupString()

        #expect(output == """
        <div class="markdown"><p><em>i</em>, <strong>b</strong>, and <em><strong>b&i</strong></em></p></div>
        """)
    }

    @Test("Strikethrough")
    func strikethrough() {
        // Given
        let element = Text {
            Strikethrough {
                "There will be a few tickets available at the box office tonight."
            }
        }
        // When
        let output = element.markupString()
        // Then
        #expect(output == """
        <p><s>There will be a few tickets available at the box office tonight.</s></p>
        """)
    }
}
