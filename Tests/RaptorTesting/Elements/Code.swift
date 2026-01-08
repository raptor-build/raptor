//
//  Code.swift
//  Raptor
//  https://raptor.build
//  See LICENSE for license information.
//

import Foundation
import Testing

@testable import Raptor

/// Tests for the `Code` element.
@Suite("Code Tests")
struct CodeTests {
    @Test("Inline code formatting")
    func inlineCode() {
        let element = Code("background-color")
        let output = withTestRenderingEnvironment {
            element.markupString()
        }
        #expect(output == "<code>background-color</code>")
    }
}
