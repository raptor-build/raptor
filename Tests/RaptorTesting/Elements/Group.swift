//
//  Group.swift
//  Raptor
//  https://raptor.build
//  See LICENSE for license information.
//

import Foundation
import Testing

@testable import Raptor

/// Tests for the `Group` element.
@Suite("Group Tests")
struct GroupTests {
    @Test("Group does not change HTML structure")
    func groupDoesNotAddAnyAdditionalHTML() {
        let element = Group {
            ControlLabel("Top Label")
            Text("Middle Text")
            Button("Bottom Button") {
                ShowAlert(message: "Bottom Button Tapped")
            }
        }

        let output = withTestRenderingEnvironment {
            element.markupString()
        }

        #expect(output == """
        <label>Top Label</label>\
        <p>Middle Text</p>\
        <button type="button" class="btn" onclick="alert('Bottom Button Tapped')">Bottom Button</button>
        """)
    }

    @Test("Adding attributes to all children")
    func groupAppliesCustomAttributesToAllChildren() {
        let attributeName = "data-info"
        let attributeValue = "Raptor"
        let element = Group {
            ControlLabel("Top Label")
            Text("Middle Text")
            Button("Bottom Button") {
                ShowAlert(message: "Bottom Button Tapped")
            }
        }.customAttribute(name: attributeName, value: attributeValue)

        let output = withTestRenderingEnvironment {
            element.markupString()
        }

        #expect(output == """
        <label \(attributeName)="\(attributeValue)">Top Label</label>\
        <p \(attributeName)="\(attributeValue)">Middle Text</p>\
        <button \(attributeName)="\(attributeValue)" type="button" class="btn" \
        onclick="alert('Bottom Button Tapped')">Bottom Button</button>
        """)
    }
}
