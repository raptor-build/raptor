//
//  CustomAction.swift
//  Raptor
//  https://raptor.build
//  See LICENSE for license information.
//

import Foundation
import Testing

@testable import Raptor

/// Tests for the `CustomAction` action.
@Suite("CustomAction Tests")
struct CustomActionTests {
    private static let inputCode: [String] = [
        "example code",
        "special characters: \\@*_+-./",
        "double quotes: \"example\"",
        "single quotes: 'example'",
        """
        multiline string
        with double quotes "example"
        and single quotes 'example'
        """
    ]

    private static let outputCode: [String] = [
        "example code",
        "special characters: \\@*_+-./",
        "double quotes: &quot;example&quot;",
        "single quotes: \\'example\\'",
        "multiline string\nwith double quotes &quot;example&quot;\nand single quotes \\'example\\'"
    ]

    @Test("Test initializer", arguments: zip(inputCode, inputCode))
    func initializer(input: String, output: String) {
        let action = CustomAction(input)
        #expect(action.compile() == output.escapedForJavascript())
    }

    @Test("Verify compile action returns escaped code", arguments: zip(inputCode, outputCode))
    func compile(input: String, output: String) {
        let action = CustomAction(input)
        #expect(action.compile() == output)
    }
}
