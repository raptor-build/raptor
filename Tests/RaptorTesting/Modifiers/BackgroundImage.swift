//
//  BackgroundImage.swift
//  Raptor
//  https://raptor.build
//  See LICENSE for license information.
//

import Foundation
import Testing

@testable import Raptor

/// Tests for the `BackgroundImage` modifier.
@Suite("BackgroundImage Tests")
struct BackgroundImageTests {
    @Test("Background Image Content Mode", arguments: [
        BackgroundImageContentMode.original, .fill, .fit,
        .size(width: "25px", height: "25px")])
    func backgroundImage(contentMode: BackgroundImageContentMode) {
        let element = Text {
            "Hello World!"
        }.background(image: "assets/image.png", contentMode: contentMode)
        let output = element.markupString()

        #expect(output == """
        <p \
        style="background-image: url('assets/image.png'); \
        background-repeat: no-repeat; \
        background-position: center center; \
        \(contentMode.style.description)">Hello World!\
        </p>
        """)
    }

    @Test("Background Image Position", arguments: [
        BackgroundPosition.center, .top, .bottom, .leading, .trailing,
        .topLeading, .topTrailing, .bottomLeading, .bottomTrailing,
        .position(vertical: .fixed(25), relativeTo: .center, horizontal: .fixed(25), relativeTo: .center)
    ])
    func backgroundPosition(position: BackgroundPosition) {
        let element = Text {
            "Hello World!"
        }.background(image: "assets/image.png", contentMode: .fill, position: position)
        let output = element.markupString()

        #expect(output == """
        <p \
        style="background-image: url('assets/image.png'); \
        background-repeat: no-repeat; \
        background-position: \(position.css); \
        background-size: cover">Hello World!\
        </p>
        """)
    }
}
