//
//  ZStack.swift
//  Raptor
//  https://raptor.build
//  See LICENSE for license information.
//

import Foundation
import Testing

@testable import Raptor

/// Tests for the `ZStack` element.
@Suite("ZStack Tests")
struct ZStackTests {
    private static let alignments: [Alignment] = [
        .top, .topLeading, .topTrailing,
        .leading, .center, .trailing,
        .bottom, .bottomLeading, .bottomTrailing
    ]

    @Test("ZStack with elements")
    func basicZStack() {
        let element = ZStack {
            ControlLabel("Top Label")
            ControlLabel("Bottom Label")
        }
        let output = element.markupString()

        #expect(output == """
        <div style="display: grid">\
        <div style="position: relative; grid-area: 1 / 1 / auto / auto; \
        z-index: 0; align-self: center; justify-self: center">\
        <label>Top Label</label></div>\
        <div style="position: relative; grid-area: 1 / 1 / auto / auto; \
        z-index: 1; align-self: center; justify-self: center">\
        <label>Bottom Label</label></div>\
        </div>
        """)
    }
}
