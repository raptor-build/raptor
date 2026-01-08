//
//  Shadow.swift
//  Raptor
//  https://raptor.build
//  See LICENSE for license information.
//

import Foundation
import Testing

@testable import Raptor

/// Tests for the `Shadow` modifier.
@Suite("Shadow Tests")
struct ShadowTests {
    @Test("Shadow Modifier", arguments: [5, 20])
    func shadowRadius(radius: Int) {
        let element = InlineText("Hello").shadow(radius: radius)
        let output = element.markupString()

        #expect(output == "<span style=\"box-shadow: 0px 0px \(radius)px rgb(0 0 0 / 33%)\">Hello</span>")
    }
}
