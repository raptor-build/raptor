//
// StyleGenerator.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

import Testing
@testable import Raptor

@Suite("StyleGenerator Tests")
struct StyleGeneratorTests {
    /// A simple style with no environment conditions.
    private struct SimpleFontStyle: Style {
        func style(content: Content, environment: EnvironmentConditions) -> Content {
            content.fontWeight(.black)
        }
    }

    /// A style with a single environment-dependent branch.
    private struct ConditionalOpacityStyle: Style {
        func style(content: Content, environment: EnvironmentConditions) -> Content {
            if environment.colorScheme == .dark {
                content.opacity(50%)
            } else {
                content
            }
        }
    }

    /// Splits CSS output into individual rule blocks.
    ///
    /// Blocks are separated by blank lines (`\n\n`), which is the
    /// canonical separator used by the style generator.
    private func ruleBlocks(from css: String) -> [String] {
        css
            .split(separator: "\n\n")
            .map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }
            .filter { !$0.isEmpty }
    }

    /// Asserts that no duplicate rule blocks exist in the given CSS.
    private func assertNoDuplicateRules(
        _ css: String,
        sourceLocation: SourceLocation = #_sourceLocation
    ) {
        let blocks = ruleBlocks(from: css)
        let unique = Set(blocks)

        #expect(
            blocks.count == unique.count,
            "Duplicate CSS rule blocks detected",
            sourceLocation: sourceLocation
        )
    }

    /// Normalizes CSS output by collapsing whitespace and formatting
    /// differences to enable stable string comparisons in tests.
    private func normalizeCSS(_ css: String) -> String {
        css
            .replacing(/\s+/, with: " ")
            .replacing(" {", with: "{")
            .replacing("; ", with: ";")
            .trimmingCharacters(in: .whitespacesAndNewlines)
    }

    /// Verifies that a basic style generates the expected CSS output.
    @Test("Simple style generates correct base CSS")
    func simpleStyleCSSOutput() async {
        let style = SimpleFontStyle()
        let generator = StyleGenerator(rawStyles: [style])

        let css = await generator.generate()
        let normalized = normalizeCSS(css)

        let expectedClass = style.className
        let expectedCSS = normalizeCSS("""
            .\(expectedClass) {
                font-weight: 900;
            }
            """)

        #expect(normalized.contains(expectedCSS))
    }

    /// Verifies that environment-conditional styles emit a media query.
    @Test("Conditional style generates color-scheme-scoped CSS")
    func conditionalStyleCSSOutput() async {
        let style = ConditionalOpacityStyle()
        let generator = StyleGenerator(rawStyles: [style])

        let css = await generator.generate()
        let normalized = normalizeCSS(css)

        let expectedClass = style.className

        #expect(normalized.contains(expectedClass))
        #expect(normalized.contains("opacity: 50"))
        #expect(normalized.contains(#"[data-color-scheme="dark"]"#))
    }

    /// Ensures that identical style instances produce the same class name.
    @Test("Style className is stable across builds")
    func styleClassNameIsStable() {
        let first = SimpleFontStyle().className
        let second = SimpleFontStyle().className
        let third = SimpleFontStyle().className

        #expect(first == second)
        #expect(second == third)
    }

    /// Guards against accidental CSS duplication in output.
    @Test("Generated CSS contains no duplicate rule blocks")
    func noDuplicateCSSBlocks() async {
        let style = SimpleFontStyle()
        let generator = StyleGenerator(rawStyles: [style])

        let css = await generator.generate()
        let blocks = css
            .split(separator: "\n\n")
            .map(String.init)

        let uniqueBlocks = Set(blocks)

        #expect(blocks.count == uniqueBlocks.count)
    }

    /// Ensures `renderVariants` never produces duplicate rule blocks
    /// when multiple variants are present.
    @Test("renderVariants does not emit duplicate CSS blocks")
    func renderVariantsDoesNotDuplicateRules() {
        let scopedStyle =
            EnvironmentEffectConfiguration<HorizontalSizeClass>.expandedConfiguration { effect, size in
                size == .compact
                    ? effect.hidden(true)
                    : effect.hidden(false)
            }
            .scopedStyle

        let generator = StyleGenerator(scopedStyles: [scopedStyle])
        let cssBlocks = generator.renderVariants(scopedStyle, themes: [])
        let css = cssBlocks.joined(separator: "\n\n")

        assertNoDuplicateRules(css)
    }

    /// Ensures `generateComponentCSS()` never emits duplicate rule blocks
    /// even when multiple scoped styles are registered.
    @Test("generateComponentCSS does not emit duplicate CSS blocks")
    func componentCSSDoesNotDuplicateRules() {
        let first =
            EnvironmentEffectConfiguration<HorizontalSizeClass>.expandedConfiguration { effect, size in
                size == .compact
                    ? effect.fontScale(1.2)
                    : effect
            }
            .scopedStyle

        let second =
            BooleanEnvironmentEffectConfiguration.expandedConfiguration(
                keyPath: \.isMotionReduced
            ) { effect, reduced in
                reduced
                    ? effect.fontScale(1.1)
                    : effect.fontScale(1.0)
            }
            .scopedStyle

        let generator = StyleGenerator(scopedStyles: [first, second])
        let css = generator.generateComponentCSS()

        assertNoDuplicateRules(css)
    }

    /// Ensures the full async `generate()` pipeline never emits
    /// duplicate CSS rule blocks.
    @Test("generate() output contains no duplicate CSS blocks")
    func fullGenerateDoesNotDuplicateRules() async {
        let scoped =
            EnvironmentEffectConfiguration<HorizontalSizeClass>.expandedConfiguration { effect, size in
                size == .compact
                    ? effect.hidden(true)
                    : effect.hidden(false)
            }
            .scopedStyle

        let generator = StyleGenerator(scopedStyles: [scoped])
        let css = await generator.generate()

        assertNoDuplicateRules(css)
    }

    @Test("hidden(compact) generates correct media query")
    func hiddenCompactCSSIsCorrect() {
        let scoped =
        EnvironmentEffectConfiguration<HorizontalSizeClass>.expandedConfiguration { effect, size in
            size == .compact
            ? effect.hidden(true)
            : effect
        }
        .scopedStyle

        let generator = StyleGenerator(scopedStyles: [scoped])

        let css = generator.generateComponentCSS()
        let normalized = normalizeCSS(css)

        let expected = normalizeCSS("""
          @media (max-width: 575px) {
              .\(scoped.baseClass) {
                  display: none !important;
              }
          }
          """)

        #expect(normalized.contains(expected))
    }
}
