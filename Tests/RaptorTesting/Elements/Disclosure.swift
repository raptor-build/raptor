//
// Disclosure.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

@testable import Raptor
import Testing

@Suite("Disclosure Tests")
struct DisclosureTests {
    // MARK: - Basic Rendering

    @Test("Basic Disclosure renders closed by default")
    func disclosure_rendersClosedByDefault() {
        let element = Disclosure("Title") {
            Text("Content")
        }

        let output = element.markupString()

        #expect(output.contains("<details"))
        #expect(output.contains("<summary"))
        #expect(output.contains("class=\"disclosure\""))
        #expect(!output.contains(" open"))
    }

    @Test("Disclosure renders open when isExpanded is true")
    func disclosure_rendersOpen() {
        let element = Disclosure("Title", isExpanded: true) {
            Text("Content")
        }

        let output = element.markupString()

        #expect(output.contains("<details"))
        #expect(output.contains(" open"))
        #expect(output.contains("aria-expanded=\"true\""))
    }

    // MARK: - ARIA & Accessibility

    @Test("Disclosure wires summary and content with ARIA attributes")
    func disclosure_hasCorrectARIAWiring() {
        let element = Disclosure("Title") {
            Text("Content")
        }

        let output = element.markupString()

        #expect(output.contains("aria-controls=\"content-"))
        #expect(output.contains("aria-labelledby=\"summary-"))
        #expect(output.contains("role=\"button\""))
        #expect(output.contains("role=\"region\""))
        #expect(output.contains("tabindex=\"0\""))
    }

    // MARK: - Label Rendering

    @Test("Disclosure renders string label correctly")
    func disclosure_rendersStringLabel() {
        let element = Disclosure("My Label") {
            Text("Content")
        }

        let output = element.markupString()

        #expect(output.contains(">My Label<"))
    }

    @Test("Disclosure renders custom inline label content")
    func disclosure_rendersCustomLabel() {
        let element = Disclosure {
            Text("Content")
        } label: {
            InlineText("Advanced")
                .fontWeight(.bold)
        }

        let output = element.markupString()

        #expect(output.contains("Advanced"))
        #expect(output.contains("font-weight"))
    }

    // MARK: - Indicator

    @Test("Disclosure applies indicator CSS variable when specified")
    func disclosure_appliesIndicator() {
        let element = Disclosure("Title") {
            Text("Content")
        }
        .disclosureLabelIndicator(.chevronRight)

        let output = element.markupString()

        #expect(output.contains("--disc-indicator"))
    }

    // MARK: - Accordion / Grouping

    @Test("Disclosure sets group name when matchedTransitionEffect is used")
    func disclosure_setsGroupName() {
        let element = Disclosure("Title") {
            Text("Content")
        }
        .matchedTransitionEffect(id: "settings")

        let output = element.markupString()

        #expect(output.contains("name=\"settings\""))
    }

    @Test("Multiple disclosures share the same group name")
    func disclosure_groupingIsConsistent() {
        let first = Disclosure("One") {
            Text("First")
        }
        .matchedTransitionEffect(id: "group")

        let second = Disclosure("Two") {
            Text("Second")
        }
        .matchedTransitionEffect(id: "group")

        let output1 = first.markupString()
        let output2 = second.markupString()

        #expect(output1.contains("name=\"group\""))
        #expect(output2.contains("name=\"group\""))
    }

    // MARK: - Attribute passthrough

    @Test("Disclosure forwards attributes to outer container")
    func disclosure_forwardsAttributes() {
        let element = Disclosure("Title") {
            Text("Content")
        }
        .class("custom-class")
        .id("my-disclosure")

        let output = element.markupString()

        #expect(output.contains("class=\"custom-class"))
        #expect(output.contains("id=\"my-disclosure\""))
    }

    // MARK: - Structural Guarantees

    @Test("Disclosure always renders summary before content")
    func disclosure_summaryPrecedesContent() {
        let element = Disclosure("Title") {
            Text("Content")
        }

        let output = element.markupString()

        let summaryIndex = output.range(of: "<summary")!.lowerBound
        let contentIndex = output.range(of: "disc-content")!.lowerBound

        #expect(summaryIndex < contentIndex)
    }
}
