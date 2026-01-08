//
//  RaptorFooter.swift
//  Raptor
//  https://raptor.build
//  See LICENSE for license information.
//

import Foundation
import Testing

@testable import Raptor

/// Tests for the `RaptorFooter` element.
@Suite("RaptorFooter Tests")
struct RaptorFooterTests {
    @Test("Default Raptor Footer")
    func defaultRaptorFooter() {
        let element = RaptorFooter()
        let output = withTestRenderingEnvironment {
            element.markupString()
        }

        #expect(output == """
        <p class="mt-5" style="text-align: center">\
        Created in Swift with \
        <a href="https://raptor.build">Raptor</a>\
        </p>
        """)
    }
}
