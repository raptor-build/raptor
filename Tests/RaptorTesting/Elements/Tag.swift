//
//  Tag.swift
//  Raptor
//  https://raptor.build
//  See LICENSE for license information.
//

import Foundation
import Testing

@testable import Raptor

/// Tests for the `Tag` element.
@Suite("Tag Tests")
struct TagTests {
    @Test("Basic Tag", arguments: ["tag_1", "tag_2", "tag_3"])
    func basicTag(tagName: String) {
        // Given
        let element = Tag(tagName)
        // When
        let output = element.markupString()

        // Then
        #expect(output == "<\(tagName)></\(tagName)>")
    }

    @Test("Tag with single element", arguments: ["tag_1", "tag_2", "tag_3"])
    func tagWithSingleElement(tagName: String) {
        // Given
        let htmlElement = InlineText("Test Span")
        let element = Tag(tagName) { htmlElement }

        // When
        let output = element.markupString()

        // Then
        #expect(output == "<\(tagName)><span>Test Span</span></\(tagName)>")
    }

    @Test("Tag with multiple elements", arguments: ["tag_1", "tag_2", "tag_3"])
    func tagWithMultipleElements(tagName: String) {
        // Given
        let element = Tag(tagName) {
            InlineText("Test Span 1")
            InlineText("Test Span 2")
        }

        // When
        let output = element.markupString()

        // Then
        #expect(output == "<\(tagName)><span>Test Span 1</span><span>Test Span 2</span></\(tagName)>")
    }
}
