//
//  Include.swift
//  Raptor
//  https://raptor.build
//  See LICENSE for license information.
//

import Foundation
import Testing

@testable import Raptor

/// Tests for the `Include` element.
@Suite("Include Tests")
struct IncludeTests {
    @Test("Basic Include")
    func basicInclude() {
        let element = Include("important.html")
        let output = withTestRenderingEnvironment {
            element.markupString()
        }

        #expect(output == "")
    }
}
