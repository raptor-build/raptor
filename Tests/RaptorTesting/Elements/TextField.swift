//
//  TextField.swift
//  Raptor
//  https://raptor.build
//  See LICENSE for license information.
//

import Foundation
import Testing

@testable import Raptor

/// Tests for the `TextField` element.
@Suite("TextField Tests")
struct TextFieldTests {

    @Test("TextField with Text Type", arguments: TextContentType.allCases)
    func textFieldWithInputTextType(textType: TextContentType) {
        let element = TextField("Steve", prompt: "Enter your name here")
            .textContentType(textType)
            .id("field")

        let output = element.markupString()

        #expect(output == """
        <div class="form-field">\
        <div class="field-label"><label for="field">Steve</label></div>\
        <div class="field-control"><input id="field" type="\(textType.rawValue)" \
        placeholder="Enter your name here" /></div>\
        </div>
        """)
    }

    @Test("TextField is required")
    func textFieldIsRequired() {
        let element = TextField("Steve", prompt: "Enter your name here")
            .required()
            .id("field")

        let output = element.markupString()

        // Structure
        #expect(output.contains(#"<div class="form-field">"#))
        #expect(output.contains(#"<label for="field">Steve</label>"#))

        // Input semantics
        #expect(output.contains(#"<input"#))
        #expect(output.contains(#"id="field""#))
        #expect(output.contains(#"type="text""#))
        #expect(output.contains(#"placeholder="Enter your name here""#))
        #expect(output.contains(#"required"#))
    }

    @Test("TextField is disabled")
    func textFieldIsDisabled() {
        let element = TextField("Steve", prompt: "Enter your name here")
            .disabled()
            .id("field")

        let output = element.markupString()

        // Structure
        #expect(output.contains(#"<div class="form-field">"#))
        #expect(output.contains(#"<label for="field">Steve</label>"#))

        // Input semantics
        #expect(output.contains(#"<input"#))
        #expect(output.contains(#"id="field""#))
        #expect(output.contains(#"type="text""#))
        #expect(output.contains(#"placeholder="Enter your name here""#))
        #expect(output.contains(#"disabled"#))
    }

    @Test("TextField is read only")
    func textFieldIsReadOnly() {
        let element = TextField("Steve")
            .readOnly("Read only")
            .id("field")

        let output = element.markupString()

        // Structure
        #expect(output.contains(#"<div class="form-field">"#))
        #expect(output.contains(#"<label for="field">Steve</label>"#))

        // Input semantics
        #expect(output.contains(#"<input"#))
        #expect(output.contains(#"id="field""#))
        #expect(output.contains(#"type="text""#))
        #expect(output.contains(#"readonly"#))
        #expect(output.contains(#"value="Read only""#))
    }
}
