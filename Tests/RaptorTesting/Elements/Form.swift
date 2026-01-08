//
//  Form.swift
//  Raptor
//  https://raptor.build
//  See LICENSE for license information.
//

import Foundation
import Testing

@testable import Raptor

/// Tests for the `Form` element.
@Suite("Form Tests")
struct FormTests {
    @Test("Basic Form renders labeled field and submit button")
    func form() {
        let element = Form {
            TextField("MyLabel", prompt: "MyPlaceholder")
                .id("field")
            Button("Submit", role: .submit)
        }

        let output = withTestRenderingEnvironment {
            element.markupString()
        }

        // Form container
        #expect(output.contains(#"<form"#))
        #expect(output.contains(#"class="form form-top""#))

        // Field structure
        #expect(output.contains(#"<div class="form-field">"#))
        #expect(output.contains(#"<label for="field">MyLabel</label>"#))
        #expect(output.contains(#"<input"#))
        #expect(output.contains(#"id="field""#))
        #expect(output.contains(#"placeholder="MyPlaceholder""#))

        // Submit button
        #expect(output.contains(#"<button"#))
        #expect(output.contains(#">Submit</button>"#))
    }

    @Test("Form applies label styles correctly", arguments: ControlLabelStyle.allCases)
    func form_withLabelStyle(style: ControlLabelStyle) {
        let output = withTestRenderingEnvironment {
            let element = Form {
                TextField("MyLabel", prompt: "MyPlaceholder")
                    .id("field")
                Button("Submit", role: .submit)
            }
            .labelStyle(style)

           return  element.markupString()
        }

        // Base form class
        #expect(output.contains(#"<form"#))
        #expect(output.contains(#"class="form"#))

        switch style {
        case .hidden:
            // Label is still present for accessibility
            #expect(output.contains(#"form-hidden-labels"#))
            #expect(output.contains(#"<label for="field">MyLabel</label>"#))
            #expect(output.contains(#"<input"#))

        default:
            #expect(output.contains("class=\"form \(style.formClass)\""))
            #expect(output.contains(#"<label for="field">MyLabel</label>"#))
        }

        // Button always present
        #expect(output.contains(#"<button"#))
        #expect(output.contains(#">Submit</button>"#))
    }
}
