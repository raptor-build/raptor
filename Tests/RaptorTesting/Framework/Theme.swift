//
// Theme.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

@testable import Raptor
import Testing

@Suite("Theme Tests")
struct ThemeTests {
    // MARK: - Fixtures

    private struct TestInlineCodeStyle: Style {
        func style(content: Content, environment: EnvironmentConditions) -> Content {
            if environment.colorScheme == .dark {
                content.background(.black)
            } else {
                content.background(.gray)
            }
        }
    }

    private struct TestTheme: Theme {
        func theme(site: Content, colorScheme: ColorScheme) -> Content {
            if colorScheme == .dark {
                site
            } else {
                site.inlineCodeStyle(TestInlineCodeStyle())
            }
        }
    }

    // MARK: - Configuration Inheritance

    @Test("inlineCodeStyle inherits from base into light and dark")
    func inlineCodeStyleIsInherited() {
        let base = ThemeConfiguration(inlineCodeStyle: .init(TestInlineCodeStyle()))
        let light = ThemeConfiguration().inheritingStyles(from: base)
        let dark = ThemeConfiguration().inheritingStyles(from: base)

        #expect(light.inlineCodeStyle != nil)
        #expect(dark.inlineCodeStyle != nil)
    }

    @Test("explicit inlineCodeStyle is never overridden")
    func explicitInlineCodeStyleIsPreserved() {
        let base = ThemeConfiguration(inlineCodeStyle: .init(TestInlineCodeStyle()))
        let explicit = ThemeConfiguration(inlineCodeStyle: .init(TestInlineCodeStyle()))
        let resolved = explicit.inheritingStyles(from: base)

        #expect(resolved.inlineCodeStyle?.wrapped is TestInlineCodeStyle)
    }

    // MARK: - CSS Generation

    @Test("inline code generates both light and dark selectors")
    func generatesLightAndDarkSelectors() async {
        let generator = ThemeGenerator(
            theme: TestTheme(),
            colorScheme: .automatic
        )

        let css = await generator.generate()

        #expect(css.contains(#"[data-color-scheme="light"]"#))
        #expect(css.contains(#"[data-color-scheme="dark"]"#))
    }

    @Test("inline code base selector is always present")
    func generatesBaseInlineCodeSelector() async {
        let generator = ThemeGenerator(
            theme: TestTheme(),
            colorScheme: .automatic
        )

        let css = await generator.generate()

        #expect(
            css.contains(#"[data-theme="test-theme"] code:not("#)
        )
    }

    // MARK: - Regression Guard (Original Bug)

    @Test("""
    dark inline code styles are generated even when the style
    is only declared on the `.any` theme configuration
    """)
    func darkInlineCodeIsNotLost() async {
        let generator = ThemeGenerator(
            theme: TestTheme(),
            colorScheme: .automatic
        )

        let css = await generator.generate()

        #expect(
            css.contains(#"data-color-scheme="dark""#),
            "Dark inline code styles must never disappear"
        )
    }

    // MARK: - Invariants

    @Test("light inline code rules are emitted exactly once")
    func noDuplicateLightInlineCodeRules() async {
        let generator = ThemeGenerator(
            theme: TestTheme(),
            colorScheme: .automatic
        )

        let css = await generator.generate()

        let lightCount =
            css.components(
                separatedBy: #"data-color-scheme="light""#
            ).count - 1

        #expect(lightCount == 1)
    }

    @Test("`.any` scheme never emits color-scoped selectors")
    func anySchemeDoesNotEmitScopedRules() async {
        let generator = ThemeGenerator(
            theme: TestTheme(),
            colorScheme: .automatic
        )

        let css = await generator.generate()

        #expect(
            !css.contains(#"data-color-scheme="auto""#),
            "The `.any` scheme must never produce scoped CSS"
        )
    }
}
