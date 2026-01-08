//
//  Resource.swift
//  Raptor
//  https://raptor.build
//  See LICENSE for license information.
//

import Foundation
import Testing

@testable import Raptor

/// Tests for the `Resource` element.
@Suite("Resource Tests")
struct ResourceTests {
    @Test("href string and rel string")
    func hrefStringAndRelString() {
        let element = Resource(href: "https://www.example.com", rel: "canonical")
        let output = element.markupString()

        #expect(output == "<link href=\"https://www.example.com\" rel=\"canonical\" />")
    }

    @Test("href URL and rel string")
    func hrefURLAndRelString() throws {
        let url = try #require(URL(string: "https://www.example.com"))
        let element = Resource(href: url, rel: "canonical")
        let output = element.markupString()

        #expect(output == "<link href=\"https://www.example.com\" rel=\"canonical\" />")
    }

    @Test("href string and rel LinkRelationship")
    func hrefStringAndRelRelationship() {
        let element = Resource(href: "https://www.example.com", rel: .external)
        let output = element.markupString()

        #expect(output == "<link href=\"https://www.example.com\" rel=\"external\" />")
    }

    @Test("href URL and rel LinkRelationship")
    func hrefURLAndRelRelationship() throws {
        let url = try #require(URL(string: "https://www.example.com"))
        let element = Resource(href: url, rel: .alternate)
        let output = element.markupString()

        #expect(output == "<link href=\"https://www.example.com\" rel=\"alternate\" />")
    }
}
