//
// ButtonStyle.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

import Testing
@testable import Raptor

@Suite("ButtonStyle Tests")
struct ButtonStyleTests {
    private struct TestButtonStyle: ButtonStyle {
        func style(content: Content, phase: Phase) -> Content {
            switch phase {
            case .initial:
                content.foregroundStyle(.blue)
            case .hovered:
                content.foregroundStyle(.red)
            case .pressed:
                content.foregroundStyle(.green)
            case .disabled:
                content.foregroundStyle(.gray)
            }
        }
    }

    private func selectorDescriptions(_ resolved: ScopedStyle) -> [String] {
        resolved.variants.map { $0.selector.description }
    }

    private func variant(
        _ resolved: ScopedStyle,
        matching predicate: (String) -> Bool
    ) -> ScopedStyleVariant {
        resolved.variants.first {
            predicate($0.selector.description)
        }!
    }

    @Test("ButtonStyle generates variants for all phases")
    func generatesVariantsPerPhase() {
        let resolved = TestButtonStyle().resolved

        #expect(resolved.variants.count == ButtonPhase.allCases.count)

        let selectors = selectorDescriptions(resolved)

        #expect(selectors.contains {
            !$0.contains(":hover") && !$0.contains(":active") && !$0.contains(":disabled")
        })

        #expect(selectors.contains { $0.contains(":hover") })
        #expect(selectors.contains { $0.contains(":active") })
        #expect(selectors.contains { $0.contains(":disabled") })
    }

    @Test("ButtonStyle isolates properties per phase")
    func phasePropertiesAreIsolated() {
        let resolved = TestButtonStyle().resolved

        let initial = variant(resolved) {
            !$0.contains(":hover") && !$0.contains(":active") && !$0.contains(":disabled")
        }

        let hovered = variant(resolved) { $0.contains(":hover") }
        let pressed = variant(resolved) { $0.contains(":active") }
        let disabled = variant(resolved) { $0.contains(":disabled") }

        let initialColor = initial.styleProperties.first { $0.name == "color" }
        let hoveredColor = hovered.styleProperties.first { $0.name == "color" }
        let pressedColor = pressed.styleProperties.first { $0.name == "color" }
        let disabledColor = disabled.styleProperties.first { $0.name == "color" }

        #expect(initialColor != nil)
        #expect(hoveredColor != nil)
        #expect(pressedColor != nil)
        #expect(disabledColor != nil)

        // All phases must differ
        let values = [
            initialColor!.value,
            hoveredColor!.value,
            pressedColor!.value,
            disabledColor!.value
        ]

        #expect(Set(values).count == values.count)
    }

    @Test("buttonStyle registers and applies resolved classes")
    func buttonStyleAppliesResolvedClasses() {
        let style = TestButtonStyle()

        let html = withTestRenderingEnvironment {
            Button("Press Me")
                .buttonStyle(style)
                .markupString()
        }

        for className in style.resolved.allClasses {
            #expect(html.contains(className))
        }
    }

    @Test("CSS output contains selectors for all phases")
    func cssContainsPhaseSelectors() {
        let style = TestButtonStyle()

        let css = withTestRenderingEnvironment {
            StyleGenerator()
                .renderVariants(style.resolved, themes: [])
                .joined()
        }

        let base = style.resolved.baseClass

        #expect(css.contains(".\(base)"))
        #expect(css.contains(".\(base):hover"))
        #expect(css.contains(".\(base):active"))
        #expect(css.contains(".\(base):disabled"))
    }

    @Test("Disabled phase does not leak into other phases")
    func disabledStylesAreIsolated() {
        struct DisabledOnlyStyle: ButtonStyle {
            func style(content: Content, phase: Phase) -> Content {
                switch phase {
                case .disabled:
                    content.style(.opacity(0.5))
                default:
                    content
                }
            }
        }

        let resolved = DisabledOnlyStyle().resolved

        let disabled = resolved.variants.first {
            $0.selector.description.contains(":disabled")
        }!

        let others = resolved.variants.filter {
            !$0.selector.description.contains(":disabled")
        }

        #expect(disabled.styleProperties.contains { $0.name == "opacity" })

        for variant in others {
            #expect(!variant.styleProperties.contains { $0.name == "opacity" })
        }
    }

    @Test("Multiple ButtonStyles generate distinct base classes")
    func buttonStylesDoNotCollide() {
        struct StyleA: ButtonStyle {
            func style(content: Content, phase: Phase) -> Content {
                content.foregroundStyle(.blue)
            }
        }

        struct StyleB: ButtonStyle {
            func style(content: Content, phase: Phase) -> Content {
                content.foregroundStyle(.red)
            }
        }

        let styleA = StyleA().resolved.baseClass
        let styleB = StyleB().resolved.baseClass

        #expect(styleA != styleB)
    }
}
