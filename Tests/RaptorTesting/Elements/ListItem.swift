//
//  ListItem.swift
//  Raptor
//  https://raptor.build
//  See LICENSE for license information.
//

import Foundation
import Testing

@testable import Raptor

/// Tests for the `ListItem` element.
@Suite("ListItem Tests")
struct ListItemTests {
    @Test("Standalone ListItem")
    func standAlone() {
        let element = ListItem {
            "Standalone List Item"
        }
        let output = element.markupString()

        #expect(output == "<li>Standalone List Item</li>")
    }
}
