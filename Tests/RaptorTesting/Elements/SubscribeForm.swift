//
// SubscribeForm.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

import Testing
@testable import Raptor

/// Tests for the `SubscribeForm` element.
@Suite("Subscribe Form Tests")
struct SubscribeFormTests {
    @Test("Basic Subscribe Form")
    func form() {
        let element = SubscribeForm(.sendFox(listID: "myListID", formID: "myID"))
            .emailFieldLabel("MyLabel")

        let output = withTestRenderingEnvironment {
            element.markupString()
        }

        // Form shell
        #expect(output.contains(#"<form id="myID""#))
        #expect(output.contains(#"method="post""#))
        #expect(output.contains(#"target="_blank""#))
        #expect(output.contains(#"action="https://sendfox.com/form/myListID/myID""#))
        #expect(output.contains(#"class="form form-hidden-labels sendfox-form grid""#))
        #expect(output.contains(#"data-async"#))
        #expect(output.contains(#"data-recaptcha="true""#))

        // Email field
        #expect(output.contains(#"id="sendfox_form_email""#))
        #expect(output.contains(#"name="email""#))
        #expect(output.contains(#"type="text""#))
        #expect(output.contains(#"placeholder="MyLabel""#))
        #expect(output.contains(#"aria-label="MyLabel""#))

        // Submit button
        #expect(output.contains(#"<button type="submit""#))
        #expect(output.contains(#">Subscribe</button>"#))

        // Honeypot field (hidden)
        #expect(output.contains(#"name="a_password""#))
        #expect(output.contains(#"tabindex="-1""#))
        #expect(output.contains(#"autocomplete="off""#))
        #expect(output.contains(#"aria-hidden="true""#))

        // Provider script
        #expect(output.contains(#"<script"#))
        #expect(output.contains(#"src="https://cdn.sendfox.com/js/form.js""#))
    }
}
