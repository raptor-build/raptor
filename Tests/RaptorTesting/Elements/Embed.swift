//
//  Embed.swift
//  Raptor
//  https://raptor.build
//  See LICENSE for license information.
//

import Foundation
import Testing

@testable import Raptor

/// Tests for the `Embed` element.
@Suite("Embed Tests")
struct EmbedTests {
    @Test("Basic Embed")
    func basicEmbed() {
        let element = Embed(
            title: "There was only ever going to be one video used here.",
            source: .youtube(id: "dQw4w9WgXcQ"))
        let output = withTestRenderingEnvironment {
            element.markupString()
        }

        #expect(output == """
        <iframe src="https://www.youtube-nocookie.com/embed/dQw4w9WgXcQ" \
        title="There was only ever going to be one video used here." \
        allow="accelerometer; autoplay; clipboard-write; encrypted-media; \
        gyroscope; picture-in-picture; web-share; fullscreen" \
        frameborder="0" class="w-100"></iframe>
        """)
    }
}
