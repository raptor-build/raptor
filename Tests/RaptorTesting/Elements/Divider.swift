//
//  Divider.swift
//  Raptor
//  https://raptor.build
//  See LICENSE for license information.
//

import Foundation
import Testing

@testable import Raptor

/// Tests for the `Divider` element.
@Suite("Divider Tests")
struct DividerTests {
    @Test("A single divider")
    func singleDivider() {
        let element = Divider()
        let output = element.markupString()
        #expect(output == "<hr />")
    }
}
