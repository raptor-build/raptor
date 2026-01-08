//
// PostProcessor.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

import Foundation

/// A protocol defining the basic information we need to get good
/// post parsing. This is implemented by the default
/// `MarkdownToHTML` processor included with Raptor, but users
/// can override that default in their `Site` conformance to
/// get a custom processor if needed.
public protocol PostProcessor: Sendable {
    /// Whether to remove the post's title from its body. This only applies
    /// to the first `<h1>` heading.
    var removeTitleFromBody: Bool { get }

    /// The syntax highlighter languages used within the post.
    var syntaxHighlighterLanguages: Set<SyntaxHighlighterLanguage> { get }

    /// Escapes rendered widget HTML so it is not interpreted or altered by
    /// Markdown parsing when injected into a post.
    func delimitRawMarkup(_ widgetHTML: String) -> String

    /// Returns the processed title, description, and body of the raw markup.
    mutating func process(_ markup: String) throws -> ProcessedPost
}

public extension PostProcessor {
    /// No syntax highlighter languages by default.
    var syntaxHighlighterLanguages: Set<SyntaxHighlighterLanguage> { [] }

    // Returns the widget’s rendered HTML without escaping it for Markdown.
    func delimitRawMarkup(_ widgetHTML: String) -> String {
        widgetHTML
    }
}
