//
// Post+Widgets.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

extension Post {
    /// A temporarily extracted post token that should not be processed.
    struct EscapedToken {
        /// The unique placeholder inserted into the Markdown.
        let placeholder: String

        /// The original token text, without the escape prefix.
        let original: String
    }

    /// Replaces post widget tokens in a Markdown string with rendered widget output.
    ///
    /// This method scans the provided Markdown for post widget tokens using the
    /// `@{WidgetName}` or `@{WidgetName:Content}` syntax, resolves each token
    /// against the supplied collection of registered widgets, and replaces the
    /// token with the widget’s rendered HTML representation.
    ///
    /// Dynamic widgets receive the provided content string during initialization.
    /// Static widgets ignore content.
    ///
    /// - Parameters:
    ///   - widgets: The collection of registered post widgets.
    ///   - markdown: The raw Markdown source to preprocess.
    /// - Returns: A new Markdown string with resolved widget tokens replaced
    ///   by rendered HTML.
    func injectPostWidgets(
        from widgets: [any PostWidget],
        into markdown: String
    ) -> String {
        let regex = /@\{(?!code\b|text\b)([A-Za-z_][A-Za-z0-9_]*)(?::([^}]+))?\}/
        var result = markdown

        // Iterate matches from back to front so replacements don’t invalidate ranges
        for match in markdown.matches(of: regex).reversed() {
            let widgetName = String(match.1)

            if let content = match.2.map(String.init) {
                BuildContext.setWidgetContent(content)
            }

            if let widget = resolveWidget(from: widgets, named: widgetName) {
                let widgetHTML = renderWidgetHTML(widget)
                result.replaceSubrange(match.range, with: widgetHTML)

                BuildContext.setWidgetContent(nil)
            } else if widgetName != "text" && widgetName != "code" {
                // `text` and `code` are special include tokens, not widgets, so we don't warn there.
                BuildContext.logError(.missingPostWidget(widgetName))
                // Remove the unresolved widget token from output
                result.replaceSubrange(match.range, with: "")
            }
        }

        return result
    }

    /// Renders a `PostWidget` into its final HTML string, applying markup
    /// escaping when the widget declares its output as raw markup.
    /// - Parameter widget: The post widget to render.
    /// - Returns: The rendered HTML string, escaped if required by the
    ///   widget’s markup representation.
    private func renderWidgetHTML(_ widget: any PostWidget) -> String {
        var html = widget.render().string

        if BuildContext.current.widgetIsRawHTML,
           let processor = RenderingContext.current?.site.postProcessor {
            html = processor.delimitRawMarkup(html)
        }

        BuildContext.current.widgetIsRawHTML = false
        return html
    }

    /// Resolves a post widget by name, optionally providing inline content.
    /// - Parameters:
    ///   - widgets: The collection of registered post widgets.
    ///   - name: The widget token name extracted from the post (e.g. `MyWidget`).
    /// - Returns: A resolved `PostWidget` instance, or `nil` if no matching widget exists.
    private func resolveWidget(
        from widgets: [any PostWidget],
        named name: String
    ) -> (any PostWidget)? {
        widgets.first(where: { String(describing: Swift.type(of: $0)) == name })
    }

    /// Expands `@{text:path}` tokens inside Markdown content.
    /// The file contents are injected verbatim.
    func injectTextIncludes(
        from buildDirectory: URL,
        into markdown: String
    ) -> String {
        let pattern = #/\@\{text:(.+?)\}/#
        var result = markdown

        for match in markdown.matches(of: pattern).reversed() {
            let rawPath = String(match.1)

            guard let text = loadInclude(at: rawPath, relativeTo: buildDirectory) else {
                continue
            }

            result.replaceSubrange(
                match.range,
                with: text.trimmingCharacters(in: .newlines)
            )
        }

        return result
    }

    /// Expands `@{code:noimports:file.ext}` tokens inside Markdown content.
    /// Code files are relative to the project root  and injected as fenced
    /// Markdown code blocks.
    func injectCodeIncludes(
        from buildDirectory: URL,
        into markdown: String
    ) -> String {
        let pattern = #/\@\{code(?::(noimports))?:(.+?)\}/#
        var result = markdown

        for match in markdown.matches(of: pattern).reversed() {
            let noImports = match.1 != nil
            let rawPath = String(match.2)

            guard let code = loadInclude(at: rawPath, relativeTo: buildDirectory) else {
                continue
            }

            // Infer language from file extension (optional)
            let language = SyntaxHighlighterLanguage(
                rawValue: URL(fileURLWithPath: rawPath).pathExtension
            )

            let finalCode = noImports && language != nil
                ? stripImports(from: code, language: language!)
                : code

            let languageTag = language.map { $0.rawValue } ?? ""

            let fenced = """
            ```\(languageTag)
            \(finalCode.trimmingCharacters(in: .newlines))
            ```
            """

            result.replaceSubrange(match.range, with: fenced)
        }

        return result
    }

    /// Extracts escaped post tokens (prefixed with `$`) from Markdown.
    ///
    /// Escaped tokens are replaced with temporary placeholders so they are skipped
    /// during widget and include processing.
    func extractEscapedTokens(from markdown: String) -> (String, [EscapedToken]) {
        let pattern = #/\$\@\{[^}]+\}/#
        var result = markdown
        var tokens: [EscapedToken] = []
        var counter = 0

        for match in markdown.matches(of: pattern).reversed() {
            let original = String(markdown[match.range]).dropFirst() // remove $
            let placeholder = "__ESCAPED_TOKEN_\(counter)__"
            counter += 1

            tokens.append(.init(placeholder: placeholder, original: String(original)))
            result.replaceSubrange(match.range, with: placeholder)
        }

        return (result, tokens)
    }

    /// Restores previously extracted escaped tokens back into Markdown.
    func restoreEscapedTokens(
        in markdown: String,
        tokens: [EscapedToken]
    ) -> String {
        var result = markdown
        for token in tokens {
            result = result.replacingOccurrences(
                of: token.placeholder,
                with: token.original
            )
        }
        return result
    }

    /// Resolves and loads a UTF-8 file relative to a Markdown file.
    private func loadInclude(
        at rawPath: String,
        relativeTo baseURL: URL
    ) -> String? {
        let fileURL = baseURL.appendingPathComponent(rawPath)

        guard let contents = try? String(contentsOf: fileURL, encoding: .utf8) else {
            BuildContext.logError(.unopenableFile(rawPath))
            return nil
        }

        return contents
    }

    /// Removes leading import statements from a source file for supported languages.
    ///
    /// This function strips only *leading* import-related lines (such as `import`,
    /// `use`, or `#include`) based on language-specific rules. Stripping stops as soon
    /// as a non-import, non-empty line is encountered, preserving the remainder of
    /// the file exactly as written.
    ///
    /// - Parameters:
    ///   - source: The raw source code as a single string.
    ///   - language: The syntax highlighter language, used to determine which
    ///     import rules (if any) apply.
    /// - Returns: The source code with leading import lines removed if supported
    ///   by the given language; otherwise, the original source unchanged.
    private func stripImports(
        from source: String,
        language: SyntaxHighlighterLanguage
    ) -> String {
        guard case let .leadingLines(prefixes) = language.importStrippingRule else {
            return source
        }

        let lines = source.split(separator: "\n", omittingEmptySubsequences: false)
        var index = 0

        while index < lines.count {
            let line = lines[index].trimmingCharacters(in: .whitespaces)

            if prefixes.contains(where: { line.hasPrefix($0) }) {
                index += 1
                continue
            }

            if line.isEmpty {
                index += 1
                continue
            }

            break
        }

        return lines[index...].joined(separator: "\n")
    }
}

private extension SyntaxHighlighterLanguage {
    /// Defines how (or if) import statements should be stripped from a source file.
    enum ImportStrippingRule: Sendable {
        /// Strips consecutive leading lines that begin with one of the given prefixes.
        case leadingLines(prefixes: [String])

        /// Indicates that no import stripping should be performed.
        case none
    }

    /// The import stripping behavior associated with this language.
    ///
    /// Languages that do not have a clear or consistent import syntax
    /// default to `.none` to avoid surprising behavior.
    var importStrippingRule: ImportStrippingRule {
        switch self {
        case .swift, .java, .kotlin, .javaScript, .typeScript:
            .leadingLines(prefixes: ["import "])
        case .python:
            .leadingLines(prefixes: ["import ", "from "])
        case .php, .rust:
            .leadingLines(prefixes: ["use "])
        case .c, .cPlusPlus, .objectiveC:
            .leadingLines(prefixes: ["#include"])
        default:
            .none
        }
    }
}
