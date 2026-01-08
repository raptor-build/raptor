//
// Label.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

import Foundation
import Testing

@testable import Raptor

/// Tests for the `Label` element.
@Suite("Label Tests")
struct LabelTests {
    @Test("Basic Label")
    func basicLabel() {
        let element = Label("Logo", image: "/images/logo.png")
        let output = withTestRenderingEnvironment {
            element.markupString()
        }

        #expect(output == """
        <span class="label">\
        <img src="/images/logo.png" alt="Logo" />\
        Logo\
        </span>
        """)
    }
}
