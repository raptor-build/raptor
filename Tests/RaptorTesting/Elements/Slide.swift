//
//  Slide.swift
//  Raptor
//  https://raptor.build
//  See LICENSE for license information.
//

import Foundation
import Testing

@testable import Raptor

/// Tests for the `Slide` element.
@Suite("Slide Tests")
struct SlideTests {
    @Test("Slide with Items", arguments: ScrollSnapAlignment.allCases)
    func slideWithItems(alignment: ScrollSnapAlignment) {
        let slide = Slide(Text("Item"), alignment: alignment)
        let output = slide.render().string

        #expect(output == """
        <li class="scroll-item" \
        style="scroll-snap-align: \(alignment.rawValue); list-style-type: none">\
        <p>Item</p>\
        </li>
        """)
    }
}
