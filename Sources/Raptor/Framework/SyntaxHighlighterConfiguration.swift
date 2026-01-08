//
// SyntaxHighlighterConfiguration.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

/// Configuration for syntax highlighting behavior in code blocks.
public struct SyntaxHighlighterConfiguration: Sendable {
    /// The default language automatically applied to code blocks and inline code.
    public var defaultLanguage: SyntaxHighlighterLanguage?

    /// Whether and how to display line numbers.
    public var lineNumberVisibility: Visibility

    /// How long lines should be wrapped or truncated.
    public var lineWrapping: CodeBlockLineWrapping

    /// Whether whitespace characters should be visible in rendered code.
    public var whitespaceCharacterVisibility: WhitespaceCharacterVisibility

    /// Default configuration that automatically detects languages.
    public static let automatic: Self = .init()

    /// Creates a new syntax highlighter configuration.
    /// - Parameters:
    ///   - defaultLanguage: The language automatically applied to code blocks and inline code.
    ///   - lineNumberVisibility: Whether to display line numbers.
    ///   - lineWrapping: How long lines should be wrapped or truncated.
    ///   - whitespaceCharacterVisibility: Whether whitespace characters are shown.
    public init(
        defaultLanguage: SyntaxHighlighterLanguage? = nil,
        lineNumberVisibility: Visibility = .hidden,
        lineWrapping: CodeBlockLineWrapping = .disabled,
        whitespaceCharacterVisibility: WhitespaceCharacterVisibility = .hidden
    ) {
        self.defaultLanguage = defaultLanguage
        self.lineNumberVisibility = lineNumberVisibility
        self.lineWrapping = lineWrapping
        self.whitespaceCharacterVisibility = whitespaceCharacterVisibility
    }
}
