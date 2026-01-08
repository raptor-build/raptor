//
// SyntaxHighlighterThemeTests.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

import Testing
@testable import Raptor

@Suite("SyntaxHighlighterTheme Tests")
struct SyntaxHighlighterThemeTests {
    /// Ensures that the theme identifier derived from the type name
    /// is stable and deterministic.
    @Test("SyntaxHighlighterTheme id is stable")
    func themeIDIsStable() {
        struct TestTheme: SyntaxHighlighterTheme {
            func theme(code: Content, colorScheme: ColorScheme) -> Content { code }
        }

        let id1 = TestTheme().id
        let id2 = TestTheme().id

        #expect(id1 == id2)
        #expect(!id1.isEmpty)
    }

    /// Verifies that resolving a theme evaluates it for all color schemes.
    @Test("ResolvedSyntaxHighlighterTheme resolves all schemes")
    func resolvedThemeResolvesAllSchemes() {
        struct TestTheme: SyntaxHighlighterTheme {
            func theme(code: Content, colorScheme: ColorScheme) -> Content {
                switch colorScheme {
                case .any:   code.plainTextColor(.primary)
                case .light: code.plainTextColor(.black)
                case .dark:  code.plainTextColor(.white)
                }
            }
        }

        let resolved = TestTheme().resolved

        #expect(resolved.base.plainTextColor == .primary)
        #expect(resolved.light.plainTextColor == .black)
        #expect(resolved.dark.plainTextColor == .white)
    }

    /// Ensures resolving the same theme multiple times
    /// produces equivalent resolved configurations.
    @Test("ResolvedSyntaxHighlighterTheme is repeatable")
    func resolvedThemeIsRepeatable() {
        struct TestTheme: SyntaxHighlighterTheme {
            func theme(code: Content, colorScheme: ColorScheme) -> Content {
                code.keywordColor(.purple)
            }
        }

        #expect(TestTheme().resolved == TestTheme().resolved)
    }

    /// Verifies that `.light()` and `.dark()` force resolution
    /// to the correct color scheme.
    @Test("Light and Dark wrappers force scheme resolution")
    func lightAndDarkWrappersForceScheme() {
        struct TestTheme: SyntaxHighlighterTheme {
            func theme(code: Content, colorScheme: ColorScheme) -> Content {
                switch colorScheme {
                case .light: code.keywordColor(.blue)
                case .dark:  code.keywordColor(.red)
                case .any:   code
                }
            }
        }

        let theme = TestTheme()

        let lightConfig = theme.light().theme(code: .init(), colorScheme: .dark)
        let darkConfig  = theme.dark().theme(code: .init(), colorScheme: .light)

        #expect(lightConfig.keywordColor == .blue)
        #expect(darkConfig.keywordColor == .red)
    }
}
