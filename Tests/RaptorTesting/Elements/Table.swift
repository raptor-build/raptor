//
//  Table.swift
//  Raptor
//  https://raptor.build
//  See LICENSE for license information.
//

import Foundation
import Testing

@testable import Raptor

@Suite("Table Tests")
struct TableTests {
    @Test func simpleTable() {
        let element = Table { }
        let output = withTestRenderingEnvironment {
            element.markupString()
        }
        #expect(output == "<table class=\"table\"><tbody></tbody></table>")
    }
}
