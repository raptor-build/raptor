//
// DisclosureLabelStyle.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

@testable import Raptor
import Testing

@Suite("DisclosureLabelStyle Tests")
struct DisclosureLabelStyleTests {
    @Test("Resolves a variant for every disclosure phase")
    func resolvesAllPhases() {
        struct TestStyle: DisclosureLabelStyle {
            func style(content: Content, phase: DisclosurePhase) -> Content {
                content
            }
        }

        let style = TestStyle().resolved

        #expect(style.variants.count == DisclosurePhase.allCases.count)
    }

    @Test("Generates correct selectors for each phase")
    func phaseSelectorsAreCorrect() {
        struct TestStyle: DisclosureLabelStyle {
            func style(content: Content, phase: DisclosurePhase) -> Content {
                content
            }
        }

        let resolved = TestStyle().resolved

        let selectors = resolved.variants.map(\.selector.description)

        #expect(selectors.contains { $0.contains(".disclosure[open]") }) // opened
        #expect(selectors.contains { $0.contains(":hover") })            // hovered
        #expect(selectors.contains { !$0.contains("[open]") && !$0.contains(":hover") }) // closed
    }

    @Test("Styles applied in one phase do not leak into others")
    func phaseIsolation() {
        struct TestStyle: DisclosureLabelStyle {
            func style(content: Content, phase: DisclosurePhase) -> Content {
                switch phase {
                case .opened:
                    content.foregroundStyle(.init(html: .red))
                default:
                    content
                }
            }
        }

        let resolved = TestStyle().resolved

        let opened = resolved.variants.first { $0.selector.description.contains("[open]") }!
        let closed = resolved.variants.first { !$0.selector.description.contains("[open]") }!

        #expect(opened.styleProperties.contains(.color(.named("red"))))
        #expect(!closed.styleProperties.contains(.color(.named("red"))))
    }

    @Test("Disclosure indicator emits CSS variable")
    func indicatorVariableApplied() {
        struct TestStyle: DisclosureLabelStyle {
            func style(content: Content, phase: DisclosurePhase) -> Content {
                content.disclosureLabelIndicator(.chevronRight)
            }
        }

        let resolved = TestStyle().resolved

        for variant in resolved.variants {
            #expect(variant.styleProperties.contains {
                $0.name == "--disc-indicator"
            })
        }
    }

    @Test("Indicator can vary per phase")
    func indicatorPerPhase() {
        struct TestStyle: DisclosureLabelStyle {
            func style(content: Content, phase: DisclosurePhase) -> Content {
                switch phase {
                case .opened:
                    content.disclosureLabelIndicator(.minus)
                default:
                    content.disclosureLabelIndicator(.plus)
                }
            }
        }

        let resolved = TestStyle().resolved

        let opened = resolved.variants.first { $0.selector.description.contains("[open]") }!
        let closed = resolved.variants.first { !$0.selector.description.contains("[open]") }!

        #expect(opened.styleProperties.contains { $0.value.contains(DisclosureIndicator.minus.codepoint) })
        #expect(closed.styleProperties.contains { $0.value.contains(DisclosureIndicator.plus.codepoint) })
    }

    @Test("Resolved style has a stable base class")
    func baseClassIsStable() {
        struct TestStyle: DisclosureLabelStyle {
            func style(content: Content, phase: DisclosurePhase) -> Content {
                content
            }
        }

        let styleA = TestStyle().resolved.baseClass
        let styleB = TestStyle().resolved.baseClass

        #expect(styleA == styleB)
    }
}
