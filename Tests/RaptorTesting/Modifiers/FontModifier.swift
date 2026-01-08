//
//  FontModifier.swift
//  Raptor
//  https://raptor.build
//  See LICENSE for license information.
//

import Foundation
import Testing

@testable import Raptor

/// Tests for the `FontModifier` modifier.
@Suite("FontModifier Tests")
struct FontModifierTests {
    @Test("Basic Font Application")
    func basicFontApplication() {
        let element = Text {
            InlineText("Sample text")
                .font(Font(name: "Arial", size: .fixed(16), weight: .regular))
        }

        let output = withTestRenderingEnvironment {
            element.markupString()
        }

        #expect(output == """
        <p><span style="font-family: 'Arial'; font-weight: 400; font-size: 16px">Sample text</span></p>
        """)
    }

    @Test("Font Weight Application")
    func fontWeightApplication() {
        let element = Text {
            InlineText("Sample text")
                .font(Font(name: "Arial", size: .fixed(16), weight: .bold))
        }

        let output = withTestRenderingEnvironment {
            element.markupString()
        }

        #expect(output == """
        <p><span style="font-family: 'Arial'; font-weight: 700; font-size: 16px">Sample text</span></p>
        """)
    }

    @Test("Font Size Application")
    func fontSizeApplication() {
        let element = Text {
            InlineText("Sample text")
                .font(Font(name: "Arial", size: .scaled(1.5), weight: .regular))
        }

        let output = withTestRenderingEnvironment {
            element.markupString()
        }

        #expect(output == """
        <p><span style="font-family: 'Arial'; font-weight: 400; font-size: 1.5em">Sample text</span></p>
        """)
    }

    @Test("Font Family Application")
    func fontFamilyApplication() {
        let element = Text {
            InlineText("Sample text")
                .font(Font(name: "Times New Roman", size: .fixed(16), weight: .regular))
        }

        let output = withTestRenderingEnvironment {
            element.markupString()
        }

        #expect(output == """
        <p><span style="font-family: 'Times New Roman'; \
        font-weight: 400; font-size: 16px">Sample text</span></p>
        """)
    }
}
