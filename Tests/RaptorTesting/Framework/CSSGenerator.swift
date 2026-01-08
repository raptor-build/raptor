//
// CSSGenerator.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

import Testing
@testable import Raptor

@Suite("CSSGenerator Tests")
struct CSSGeneratorTests {
    private struct BaseTheme: SyntaxHighlighterTheme {
        func theme(code: Content, colorScheme: ColorScheme) -> Content {
            code.keywordColor(.red)
        }
    }

    private struct UniformTheme: SyntaxHighlighterTheme {
        func theme(code: Content, colorScheme: ColorScheme) -> Content {
            code.keywordColor(.blue)
        }
    }

    private struct LightStyledTheme: SyntaxHighlighterTheme {
        func theme(code: Content, colorScheme: ColorScheme) -> Content {
            switch colorScheme {
            case .light, .any:
                code.keywordColor(.blue)
            case .dark:
                code // intentionally plain
            }
        }
    }

    private struct DualTheme: SyntaxHighlighterTheme {
        func theme(code: Content, colorScheme: ColorScheme) -> Content {
            switch colorScheme {
            case .light: code.keywordColor(.green)
            case .dark:  code.keywordColor(.purple)
            case .any:   code.keywordColor(.orange)
            }
        }
    }

    private func makeGenerator(themes: [any SyntaxHighlighterTheme]) -> CSSGenerator {
        let site = TestSite()
        var context = BuildContext()
        context.syntaxHighlighterThemes = themes
        return CSSGenerator(site: site, buildContext: context)
    }

    /// Ensures block and inline syntax highlighting scopes are emitted.
    @Test("Emits block and inline syntax highlighting scopes")
    func emitsBlockAndInlineScopes() {
        let css = makeGenerator(themes: [BaseTheme()]).generatePrismThemeCSS()

        #expect(css.contains("data-highlighter-theme"))
        #expect(css.contains("data-inline-highlighter-theme"))
    }

    /// Ensures correct variable prefixes are used.
    @Test("Uses correct variable prefixes")
    func variablePrefixesAreCorrect() {
        let css = makeGenerator(themes: [BaseTheme()]).generatePrismThemeCSS()

        #expect(css.contains("--hl-keyword"))
        #expect(css.contains("--inline-hl-keyword"))
    }

    /// Ensures dark overrides are emitted when
    /// the dark configuration intentionally differs from base.
    @Test("Emits dark override when dark variant intentionally differs")
    func emitsDarkOverrideForPlainDarkTheme() {
        let css = makeGenerator(themes: [LightStyledTheme()])
            .generatePrismThemeCSS()

        #expect(css.contains(#"[data-highlighter-theme="light-styled-theme"][data-color-scheme="dark"]"#))
    }

    /// Ensures that no dark color-scheme override is emitted when a syntax
    /// highlighter theme resolves identically for the base and dark schemes.
    @Test("Does not emit redundant dark override when dark equals base")
    func identicalThemeOmitsDarkOverride() {
        let css = makeGenerator(themes: [UniformTheme()])
            .generatePrismThemeCSS()

        #expect(!css.contains(#"[data-highlighter-theme="uniform-theme"][data-color-scheme="dark"]"#))
    }

    /// Ensures all variants are emitted when distinct.
    @Test("Emits base, light, and dark variants when different")
    func dualThemeEmitsAllVariants() {
        let css = makeGenerator(themes: [DualTheme()]).generatePrismThemeCSS()

        #expect(css.contains("data-color-scheme=\"light\""))
        #expect(css.contains("data-color-scheme=\"dark\""))
    }

    /// Ensures multiple themes do not collide.
    @Test("Multiple syntax themes produce isolated scopes")
    func multipleThemesDoNotCollide() {
        let css = makeGenerator(themes: [BaseTheme(), DualTheme()])
            .generatePrismThemeCSS()

        #expect(css.contains("base-theme"))
        #expect(css.contains("dual-theme"))
    }

    /// Ensures deterministic CSS output.
    @Test("CSS generation is stable and repeatable")
    func cssGenerationIsStable() {
        let generator = makeGenerator(themes: [DualTheme()])

        #expect(generator.generatePrismThemeCSS()
                == generator.generatePrismThemeCSS())
    }
}
