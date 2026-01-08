//
//  Button.swift
//  Raptor
//  https://raptor.build
//  See LICENSE for license information.
//

import Foundation
import SwiftUI
import Testing

@testable import Raptor

/// Tests for the `Button` element.
@Suite("Button Tests")
struct ButtonTests {

    @Test("Button")
    func button() {
        let element = Text {
            Button("Say Hello") {
                ShowAlert(message: "Hello, world!")
            }
        }

        let output = withTestRenderingEnvironment {
            element.markupString()
        }

        #expect(output == """
        <p><button type=\"button\" \
        class=\"btn\" \
        onclick=\"alert('Hello, world!')\">Say Hello</button></p>
        """)
    }

    @Test("Show Text")
    func showText() {
        let button1 = Text {
            Button("Show First Text") {
                ShowElement("FirstText")
                HideElement("SecondText")
            }
        }

        let button2 = Text {
            Button("Show Second Text") {
                HideElement("FirstText")
                ShowElement("SecondText")
            }
        }

        let text1 = Text("This is the first text.")
            .font(.title3)
            .id("FirstText")

        let text2 = Text("This is the second text.")
            .font(.title3)
            .id("SecondText")
            .hidden()

        let outputButton1 = withTestRenderingEnvironment {
            button1.markupString()
        }

        let outputButton2 = withTestRenderingEnvironment {
            button2.markupString()
        }

        let outputText1 = text1.markupString()
        let outputText2 = text2.markupString()

        #expect(outputButton1 == """
        <p><button type="button" class="btn" \
        onclick="document.querySelectorAll('#FirstText')
          .forEach(el => el.classList.remove('d-none'));; document.querySelectorAll('#SecondText')
          .forEach(el => el.classList.add('d-none'));">Show First \
        Text</button></p>
        """)

        #expect(outputButton2 == """
        <p><button type="button" \
        class="btn" onclick="document.querySelectorAll('#FirstText')
          .forEach(el => el.classList.add('d-none'));; document.querySelectorAll('#SecondText')
          .forEach(el => el.classList.remove('d-none'));">Show Second Text</button></p>
        """)

        #expect(
            outputText1 ==
            "<h3 id=\"FirstText\">This is the first text.</h3>"
        )

        #expect(
            outputText2 ==
            "<h3 id=\"SecondText\" class=\"d-none\">This is the second text.</h3>"
        )
    }

    @Test("Disabled Button")
    func disabledButton() {
        let button = Button().disabled()

        let output = withTestRenderingEnvironment {
            button.markupString()
        }

        #expect(
            output ==
            #"<button disabled type="button" class="btn"></button>"#
        )
    }
}
