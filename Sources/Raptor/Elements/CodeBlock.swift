//
// CodeBlock.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

/// An separated section of programming code. For inline code that sit along other
/// text on your page, use `Code` instead.
///
/// - Important: If your code contains angle brackets (`<`...`>`), such as Swift generics,
/// the prettifier will interpret these as HTML tags and break the code's formatting.
/// To avoid this issue, either set your site’s `shouldPrettify` property to `false`,
/// or replace `<` and `>` with their character entity references, `&lt;` and `&gt;` respectively.
public struct CodeBlock: HTML {
    /// Controls the visibility and formatting of line numbers.
    public enum LineNumberVisibility: Equatable, Sendable {
        /// Shows line numbers with the specified starting number and wrapping behavior.
        case visible(firstLine: Int)
        /// Hides line numbers.
        case hidden

        /// Shows line numbers starting at 1 without text wrapping.
        public static let visible: Self = .visible(firstLine: 1)
    }

    /// The content and behavior of this HTML.
    public var body: Never { fatalError() }

    /// The standard set of control attributes for HTML elements.
    public var attributes = CoreAttributes()

    /// The code to display.
    private var content: String

    /// The language of the code being shown.
    private var language: SyntaxHighlighterLanguage?

    /// The visibility of line numbers.
    private var lineNumberVisibility: LineNumberVisibility?

    /// Whether long lines should break to the next line.
    private var lineWrapping: CodeBlockLineWrapping?

    /// Whether the code block displays whitespace characters.
    private var whitespaceCharacterVisibility: WhitespaceCharacterVisibility?

    /// The lines of the code block that should be highlighted.
    private var highlightedLineData: String?

    /// Custom vertical offset for highlighted lines (used in Prism’s line highlighting plugin).
    private var lineHighlightOffset: LengthUnit?

    /// The syntax highlighter configuration used by the site.
    private var configuration: SyntaxHighlighterConfiguration {
        renderingContext.site.syntaxHighlighterConfiguration
    }

    /// Computes the attributes needed for line wrapping based on instance and site settings.
    private var lineWrappingAttributes: CoreAttributes {
        let resolvedWrapping = lineWrapping ?? configuration.lineWrapping
        var attributes = CoreAttributes()

        if resolvedWrapping == .enabled {
            attributes.append(styles: .whiteSpace(.preWrap))
        }

        return attributes
    }

    /// Computes the attributes needed for line number display based on instance and site settings.
    private var lineNumberAttributes: CoreAttributes {
        let siteVisibility = configuration.lineNumberVisibility
        var attributes = CoreAttributes()

        if lineNumberVisibility == nil, siteVisibility == .visible {
            attributes.append(classes: "line-numbers")
        }

        if case .hidden = lineNumberVisibility, siteVisibility == .visible {
            attributes.append(classes: "no-line-numbers")
        }

        if case .visible(let firstLine) = lineNumberVisibility, siteVisibility == .hidden {
            attributes.append(classes: "line-numbers")
            if firstLine != 1 {
                attributes.append(dataAttributes: .init(name: "start", value: firstLine.formatted()))
            }
        }

        return attributes
    }

    /// Computes the attributes needed to display whitespace characters
    /// based on instance and site settings.
    private var whitespaceCharacterAttributes: CoreAttributes {
        var attributes = CoreAttributes()

        if let override = whitespaceCharacterVisibility {
            // Element explicitly sets the rule
            switch override {
            case .visible:
                attributes.append(classes: "show-invisibles")
            case .hidden:
                attributes.append(classes: "no-show-invisibles")
            }
            return attributes
        }

        // No override, fall back to site configuration
        switch configuration.whitespaceCharacterVisibility {
        case .visible:
            attributes.append(classes: "show-invisibles")
        case .hidden:
            // Default hidden, add nothing
            break
        }

        return attributes
    }

    /// Creates a new `Code` instance from the given content.
    /// - Parameters:
    ///   - language: The programming language for the code. This affects how the
    ///     content is tagged, which in turn affects syntax highlighting.
    ///     Passing `nil` uses the site’s default syntax-highlighting language
    ///     if one is configured.
    ///   - content: The code you want to render.
    public init(_ language: SyntaxHighlighterLanguage?, _ content: () -> String) {
        self.content = content()
        self.language = language ?? configuration.defaultLanguage
    }

    /// Creates a new `Code` instance from the given content without specifying
    /// a programming language.
    /// - Parameter content: The code you want to render.
    public init(_ content: () -> String) {
        self.content = content()
        self.language = nil
    }

    /// A code block with highlighted lines.
    /// - Parameter lines: Individual line numbers to highlight.
    /// - Returns: A copy of this code block with the specified lines highlighted.
    public func highlightedLines(_ lines: Int...) -> Self {
        var copy = self
        let highlights = lines.map { "\($0)" }
        let lineData = highlights.joined(separator: ",")
        copy.highlightedLineData = lineData
        return copy
    }

    /// A code block with highlighted line ranges.
    /// - Parameter ranges: Ranges of lines to highlight.
    /// - Returns: A copy of this code block with the specified line ranges highlighted.
    public func highlightedLines(_ ranges: ClosedRange<Int>...) -> Self {
        var copy = self
        let highlights = ranges.map { "\($0.lowerBound)-\($0.upperBound)" }
        let lineData = highlights.joined(separator: ",")
        copy.highlightedLineData = lineData
        return copy
    }

    /// A code block with highlighted lines and ranges.
    /// - Parameters:
    ///   - lines: Individual line numbers to highlight.
    ///   - ranges: Ranges of lines to highlight.
    /// - Returns: A copy of this code block with the specified lines highlighted.
    public func highlightedLines(_ lines: Int..., ranges: ClosedRange<Int>...) -> Self {
        let singleLines = lines.map { "\($0)" }
        let rangeLines = ranges.map { "\($0.lowerBound)-\($0.upperBound)" }
        let allHighlights = singleLines + rangeLines

        var copy = self
        let lineData = allHighlights.joined(separator: ",")
        copy.highlightedLineData = lineData
        return copy
    }

    /// Configures whether line numbers are shown for this code block.
    /// - Parameter visibility: The visibility configuration for line numbers,
    /// including start line and text wrapping options.
    /// - Returns: A copy of this code block with the specified line number visibility.
    public func lineNumberVisibility(_ visibility: LineNumberVisibility) -> Self {
        var copy = self
        copy.lineNumberVisibility = visibility
        return copy
    }

    /// Configures how long lines are wrapped in this code block.
    /// - Parameter mode: The line wrapping mode to apply.
    /// - Returns: A copy of this code block with the specified line wrapping setting.
    public func lineWrapping(_ mode: CodeBlockLineWrapping) -> Self {
        var copy = self
        copy.lineWrapping = mode
        return copy
    }

    /// Configures whether whitespace characters (spaces, tabs, newlines) are visible.
    /// - Parameter visibility: The whitespace character visibility mode to apply.
    /// - Returns: A copy of this code block with the specified whitespace visibility.
    public func whitespaceCharacterVisibility(_ visibility: WhitespaceCharacterVisibility) -> Self {
        var copy = self
        copy.whitespaceCharacterVisibility = visibility
        return copy
    }

    /// Adjusts the highlight line with a vertical offset.
    /// - Parameter offset: A custom offset value that is a multiplier of the font size.
    /// - Returns: A copy of this code block with the offset applied.
    public func lineHighlightOffset(_ offset: Double) -> Self {
        var copy = self
        copy.lineHighlightOffset = .em(offset)
        return copy
    }

    /// Sets the syntax highlighting theme.
    /// - Parameter theme: The syntax highlighter theme to apply.
    /// - Returns: A modified HTML element with the highlighter theme applied.
    public func syntaxHighlighterTheme(_ theme: some SyntaxHighlighterTheme) -> Self {
        BuildContext.register(theme)
        var copy = self
        copy.attributes.append(dataAttributes: .init(name: "highlighter-theme", value: theme.id))
        return copy
    }

    /// Renders this element into HTML.
    /// - Returns: The HTML for this element.
    public func render() -> Markup {
        var codeAttributes = lineWrappingAttributes
        var preAttributes = attributes
        preAttributes.merge(lineWrappingAttributes)
        preAttributes.merge(lineNumberAttributes)
        preAttributes.merge(whitespaceCharacterAttributes)

        if let highlightedLineData {
            preAttributes.append(dataAttributes: .init(name: "line", value: highlightedLineData))
        }

        if let lineHighlightOffset {
            preAttributes.append(styles: .custom("--code-line-highlight-offset", value: lineHighlightOffset.css))
        }

        if let language {
            BuildContext.register(language)
            codeAttributes.append(classes: "language-\(language)")
            return Markup("<pre\(preAttributes)><code\(codeAttributes)>\(content)</code></pre>")
        }

        return Markup("<pre\(preAttributes)><code\(codeAttributes)>\(content.markupString())</code></pre>")
    }
}
