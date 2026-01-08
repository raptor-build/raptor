//
// Text.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

/// A structured piece of text, such as a paragraph of heading. If you are just
/// placing content inside a list, table, table header, and so on, you can usually
/// just use a simple string. Using `Text` is required if you want a specific paragraph
/// of text with some styling, or a header of a particular size.
///
/// - Important: For types that accept only `InlineElement` or use `@InlineElementBuilder`,
/// use `Span` instead of `Text`.
public struct Text<Content: InlineContent>: HTML {
    /// The content and behavior of this HTML.
    public var body: Never { fatalError() }

    /// The standard set of control attributes for HTML elements.
    public var attributes = CoreAttributes()

    /// The font to use for this text.
    var fontStyle = FontStyle.body

    /// The content to place inside the text.
    private var content: Content

    /// Whether this text is Markdown.
    private var isMarkdown = false

    /// Creates a new `Text` instance using an inline element builder that
    /// returns an array of the content to place into the text.
    /// - Parameter content: An array of the content to place into the text.
    public init(@InlineContentBuilder content: () -> Content) {
        self.content = content()
    }

    /// Sets the maximum number of lines for the text to display.
    /// - Parameter number: The line limit. If `nil`, no line limit applies.
    /// - Returns: A new `Text` instance with the line limit applied.
    public func lineLimit(_ number: Int?) -> Self {
        var copy = self
        if let number {
            copy.attributes.append(classes: "line-clamp")
            copy.attributes.append(styles: .custom("--max-line-length", value: number.formatted()))
        } else {
            copy.attributes.append(classes: "line-clamp-none")
        }
        return copy
    }

    /// Renders this element into HTML.
    /// - Returns: The HTML for this element.
    public func render() -> Markup {
        if isMarkdown {
            // HTMLCollection will pass its attributes to each child.
            // This works fine for styles like color, but for styles like
            // padding, we'd expect them to apply to the paragraphs
            // collectively. So we'll wrap the paragraphs in a Section.
            return Section(content)
                .attributes(attributes)
                .class("markdown")
                .render()
        } else if FontStyle.classBasedStyles.contains(fontStyle), let sizeClass = fontStyle.sizeClass {
            let attributes = attributes.appending(classes: sizeClass)
            return Markup(
                "<p\(attributes)>" +
                content.markupString() +
                "</p>"
            )
        } else {
            return Markup(
                "<\(fontStyle.rawValue)\(attributes)>" +
                content.markupString() +
                "</\(fontStyle.rawValue)>"
            )
        }
    }
}

extension Text: @unchecked Sendable where Content == String {
    /// Creates a literal, unlocalized text element.
    init(verbatim string: String) {
        self.content = string
    }
}

public extension Text where Content == String {
    /// Creates a new `Text` instance using a localization key.
    /// This automatically looks up the key in your `.xcstrings` file.
    init(_ key: String) {
        self.content = Localizer.string(key, locale: Self.locale)
    }

    /// Creates a new `Text` instance using "lorem ipsum" placeholder text.
    /// - Parameter placeholderLength: How many placeholder words to generate.
    init(placeholderLength: Int) {
        precondition(placeholderLength > 0, "placeholderLength must be at least 1.")

        let baseWords = ["Lorem", "ipsum", "dolor", "sit", "amet,", "consectetur", "adipiscing", "elit."]

        var finalWords: [String]

        if placeholderLength < baseWords.count {
            finalWords = Array(baseWords.prefix(placeholderLength))
        } else {
            let otherWords = [
                "ad", "aliqua", "aliquip", "anim", "aute", "cillum", "commodo", "consequat", "culpa", "cupidatat",
                "deserunt", "do", "dolor", "dolore", "duis", "ea", "eiusmod", "enim", "esse", "est", "et",
                "eu", "ex", "excepteur", "exercitation", "fugiat", "id", "in", "incididunt", "irure",
                "labore", "laboris", "laborum", "magna", "minim", "mollit", "nisi", "non", "nostrud", "nulla",
                "occaecat", "officia", "pariatur", "proident", "qui", "quis", "reprehenderit", "sed", "sint", "sunt",
                "tempor", "ullamco", "ut", "velit", "veniam", "voluptate"
            ]

            var isStartOfSentence = false
            finalWords = baseWords

            for _ in baseWords.count ..< placeholderLength {
                let randomWord = otherWords.randomElement() ?? "ad"
                var formattedWord = isStartOfSentence ? randomWord.capitalized : randomWord
                isStartOfSentence = false

                // Randomly add punctuation – 10% chance of adding
                // a comma, and 10% of adding a full stop instead.
                let punctuationProbability = Int.random(in: 1 ... 10)
                if punctuationProbability == 1 {
                    formattedWord.append(",")
                } else if punctuationProbability == 2 {
                    formattedWord.append(".")
                    isStartOfSentence = true
                }

                finalWords.append(formattedWord)
            }
        }

        var result = finalWords.joined(separator: " ").trimmingCharacters(in: .punctuationCharacters)
        result += "."

        self.content = result
    }

    /// Creates a new Text struct from a Markdown string.
    /// - Parameter markdown: The Markdown text to parse.
    init(markdown: String) {
        var processor = MarkdownToHTML()
        let components = processor.process(markdown)
        self.content = components.body
        self.isMarkdown = true
    }

    /// Creates a new `Text` struct from a markup format and its processor.
    /// - Parameters:
    ///   - markdown: The Markdown text to parse.
    ///   - processor: The processor to process the text.
    init(markup: String, processor: any PostProcessor) {
        do {
            var processor = processor
            let components = try processor.process(markup)
            self.content = components.body
            self.isMarkdown = true
        } catch {
            self.content = markup
            BuildContext.logError(.failedToParseMarkup)
        }
    }
}

public extension Text {
    /// Adjusts the heading level of this text.
    /// - Parameter style: The new heading level.
    /// - Returns: A new `Text` instance with the updated font style.
    func font(_ style: Font.Style) -> Self {
        var copy = self
        copy.fontStyle = style
        return copy
    }

    /// Adjusts the font of this text.
    /// - Parameter font: The font configuration to apply.
    /// - Returns: A new instance with the updated font.
    func font(_ font: Font) -> Self {
        BuildContext.register(font)
        var copy = self
        if let style = font.style { copy.fontStyle = style }
        let attributes = FontModifier.attributes(for: font, includeStyle: false)
        copy.attributes.merge(attributes)
        return copy
    }
}
