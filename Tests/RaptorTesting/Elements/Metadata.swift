//
//  Metadata.swift
//  Raptor
//  https://raptor.build
//  See LICENSE for license information.
//

import Foundation
import Testing

@testable import Raptor

/// Tests for the `Metadata` element.
@Suite("Metadata Tests")
struct MetadataTests {
    @Test("Meta tag with type enum and content a URL")
    func withEnumAndContentURL() {
        let element = Metadata(.twitterDomain, content: URL(string: "https://example.com?s=searching#target")!)
        let output = element.render()

        #expect(output.string == "<meta name=\"twitter:domain\" content=\"https://example.com?s=searching#target\" />")
    }

    @Test("Meta tag with name and content both strings")
    func withNameAndContentBothStrings() {
        let element = Metadata(name: "tagname", content: "my content")
        let output = element.render()

        #expect(output.string == "<meta name=\"tagname\" content=\"my content\" />")
    }

    @Test("Meta tag with property and content both strings")
    func withPropertyAndContentBothStrings() {
        let element = Metadata(property: "unique", content: "my value")
        let output = element.render()

        #expect(output.string == "<meta property=\"unique\" content=\"my value\" />")
    }

    @Test("Meta tag with character set only")
    func withCharacterSet() {
        let element = Metadata(characterSet: "UTF-16")
        let output = element.render()

        #expect(output.string == "<meta charset=\"UTF-16\" />")
    }

    private func metaTagCoreFieldsMatch(_ actual: Metadata, _ expected: Metadata) -> Bool {
        let actualCustomAttributes = actual.attributes.customAttributes
        let expectedCustomAttributes = expected.attributes.customAttributes
        let actualDict = Dictionary(uniqueKeysWithValues: actualCustomAttributes.map { ($0.name, $0.value) })
        let expectedDict = Dictionary(uniqueKeysWithValues: expectedCustomAttributes.map { ($0.name, $0.value) })
        let keysToCompare = ["name", "property", "content", "charset", "http-equiv"]

        for key in keysToCompare where actualDict[key] != expectedDict[key] {
            return false
        }

        return true
    }
}
