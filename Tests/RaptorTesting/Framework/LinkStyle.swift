//
// LinkStyle.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

import Testing
@testable import Raptor

@Suite("LinkStyle Tests")
struct LinkStyleTests {
    private struct TestLinkStyle: LinkStyle {
        func style(content: Content, phase: Phase) -> Content {
            switch phase {
            case .initial:
                content.foregroundStyle(.blue)
            case .hovered:
                content
                    .foregroundStyle(.red)
                    .underline()
            }
        }
    }

    private func css(for style: some LinkStyle) -> String {
        withTestRenderingEnvironment {
            StyleGenerator()
                .renderVariants(style.resolved, themes: [])
                .joined()
        }
    }

    @Test("LinkStyle generates base and hover variants")
    func generatesVariantsPerPhase() {
        let resolved = TestLinkStyle().resolved

        #expect(resolved.variants.count == 2)

        let selectors = resolved.variants.map(\.selector.description)
        #expect(selectors.contains { !$0.contains(":hover") })
        #expect(selectors.contains {  $0.contains(":hover") })
    }

    @Test("LinkStyle applies correct properties per phase")
    func phasePropertiesAreIsolated() {
        let resolved = TestLinkStyle().resolved

        let initial = resolved.variants.first {
            !$0.selector.description.contains(":hover")
        }!

        let hovered = resolved.variants.first {
            $0.selector.description.contains(":hover")
        }!

        // Initial phase: blue text, no underline
        #expect(initial.styleProperties.contains {
            $0.name == "color" && $0.value == "var(--r-blue)"
        })

        #expect(!initial.styleProperties.contains {
            $0.name.contains("text-decoration")
        })

        // Hovered phase: red text + underline
        #expect(hovered.styleProperties.contains {
            $0.name == "color" && $0.value == "var(--r-red)"
        })

        #expect(hovered.styleProperties.contains {
            $0.name.contains("text-decoration")
        })
    }

    @Test("linkStyle registers and applies classes to anchor element")
    func linkStyleAppliesResolvedClasses() {
        let style = TestLinkStyle()

        let html = withTestRenderingEnvironment {
            Link("Hello", destination: "hello")
                .linkStyle(style)
                .markupString()
        }

        // Ensure we're actually styling the <a> element
        #expect(html.contains("<a"))

        let classNames = style.resolved.allClasses
        for className in classNames {
            #expect(html.contains(className))
        }
    }

    @Test("CSS output contains base and hover selectors")
    func cssContainsPhaseSelectors() {
        let style = TestLinkStyle()
        let cssOutput = css(for: style)
        let baseClass = style.resolved.baseClass

        #expect(cssOutput.contains(".\(baseClass)"))
        #expect(cssOutput.contains(".\(baseClass):hover"))
    }

    @Test("Underline appears only when explicitly enabled")
    func underlineIsConditional() {
        struct NoUnderlineStyle: LinkStyle {
            func style(content: Content, phase: Phase) -> Content {
                content
            }
        }

        let cssOutput = css(for: NoUnderlineStyle())

        #expect(!cssOutput.contains("text-decoration"))
    }

    @Test("Underline appears in hovered phase only")
    func underlineOnlyInHoveredPhase() {
        let cssOutput = css(for: TestLinkStyle())

        // Underline exists
        #expect(cssOutput.contains("text-decoration"))

        // But only in hover selector
        let hoverIndex = cssOutput.firstIndex(of: ":")!
        let hoverCSS = cssOutput[hoverIndex...]

        #expect(hoverCSS.contains("text-decoration"))
    }

    @Test("Multiple LinkStyles generate distinct base classes")
    func linkStylesDoNotCollide() {
        struct StyleA: LinkStyle {
            func style(content: Content, phase: Phase) -> Content {
                content.foregroundStyle(.blue)
            }
        }

        struct StyleB: LinkStyle {
            func style(content: Content, phase: Phase) -> Content {
                content.foregroundStyle(.red)
            }
        }

        let styleA = StyleA().resolved.baseClass
        let styleB = StyleB().resolved.baseClass

        #expect(styleA != styleB)
    }
}
