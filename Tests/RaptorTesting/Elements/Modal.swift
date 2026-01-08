//
//  Modal.swift
//  Raptor
//  https://raptor.build
//  See LICENSE for license information.
//

import Foundation
import Testing

@testable import Raptor

/// Tests for the `Modal` element.
@Suite("Modal Tests")
struct ModalTests {
    @Test("Show Modals")
    func showModal() {
        let element = Modal(id: "showModalId") {
            Text("Dismiss me by clicking on the backdrop.")
                .font(.title3)
                .margin(.xLarge)
        }

        let output = withTestRenderingEnvironment {
            element.markupString()
        }

        #expect(output == """
        <dialog id="showModalId" tabindex="-1" closedby="closerequest" \
        class="presentation-align-center" aria-hidden="true">\
        <h3 class="m-5">Dismiss me by clicking on the backdrop.</h3>\
        </dialog>
        """)
    }

    @Test("Dismissing Modals")
    func dismissModal() {
        let element = Modal(id: "dismissModalId") {
            Section {
                Button().onClick {
                    DismissModal("dismissModalId")
                }
            }

            Text("Dismiss me by clicking on the close button.")
                .font(.title3)
                .margin(.xLarge)
        }

        let output = withTestRenderingEnvironment {
            element.markupString()
        }

        #expect(output == """
        <dialog id="dismissModalId" tabindex="-1" closedby="closerequest" \
        class="presentation-align-center" aria-hidden="true">\
        <div>\
        <button type="button" class="btn" onclick="closeModal('dismissModalId');"></button>\
        </div>\
        <h3 class="m-5">Dismiss me by clicking on the close button.</h3>\
        </dialog>
        """)
    }

    @Test("Modal Headers and Footers")
    func modalHeadersAndFooters() {
        let element = Modal(id: "headerAndFooterModalId") {
            Text("Body")
        }

        let output = withTestRenderingEnvironment {
            element.markupString()
        }

        #expect(output == """
        <dialog id="headerAndFooterModalId" tabindex="-1" closedby="closerequest" \
        class="presentation-align-center" aria-hidden="true">\
        <p>Body</p>\
        </dialog>
        """)
    }
}
