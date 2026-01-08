//
// Code.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

/// An inline snippet of programming code, embedded inside a larger part
/// of your page. For dedicated code blocks that sit on their own line, use
/// `CodeBlock` instead.
///
/// - Important: If your code contains angle brackets (`<`...`>`), such as Swift generics,
/// the prettifier will interpret these as HTML tags and break the code's formatting.
/// To avoid this issue, either set your site’s `shouldPrettify` property to `false`,
/// or replace `<` and `>` with their character entity references, `&lt;` and `&gt;` respectively.
public struct Code<Content: InlineContent>: InlineContent {
    /// The content and behavior of this HTML.
    public var body: Never { fatalError() }

    /// The standard set of control attributes for HTML elements.
    public var attributes = CoreAttributes()

    /// The code to display.
    private var content: Content

    /// The language used by the syntax highlighter.
    private var language: SyntaxHighlighterLanguage?

    /// The syntax highlighter configuration used by the site.
    private var configuration: SyntaxHighlighterConfiguration {
        renderingContext.site.syntaxHighlighterConfiguration
    }

    /// Creates a new `Code` instance from the given content.
    /// - Parameters:
    ///   - content: The code you want to render.
    ///   - language: The programming language for the code. This affects how the
    ///     content is tagged, which in turn affects syntax highlighting.
    ///     Passing `nil` uses the site’s default syntax-highlighting language
    ///     if one is configured.
    public init(
        _ content: String,
        language: SyntaxHighlighterLanguage?
    ) where Content == String {
        self.content = content
        self.language = language ?? configuration.defaultLanguage
    }

    /// Creates a new `Code` instance from the given content without specifying
    /// a programming language.
    /// - Parameter content: The code you want to render.
    public init(_ content: String) where Content == String {
        self.content = content
        self.language = nil
    }

    /// Creates a new `Code` instance from the given content.
    /// - Parameters:
    ///   - language: The programming language for the code. This affects how the
    ///     content is tagged, which in turn affects syntax highlighting.
    ///     Passing `nil` uses the site’s default syntax-highlighting language
    ///     if one is configured.
    ///   - content: The code you want to render.
    public init(
        language: SyntaxHighlighterLanguage?,
        @InlineContentBuilder content: () -> Content
    ) {
        self.content = content()
        self.language = language ?? configuration.defaultLanguage
    }

    /// Creates a new `Code` instance from the given content without specifying
    /// a programming language.
    /// - Parameter content: The code you want to render.
    public init(@InlineContentBuilder content: () -> Content) {
        self.content = content()
        self.language = nil
    }

    /// Sets the syntax highlighting theme.
    /// - Parameter theme: The syntax highlighter theme to apply.
    /// - Returns: A modified HTML element with the highlighter theme applied.
    public func syntaxHighlighterTheme(_ theme: some SyntaxHighlighterTheme) -> Self {
        BuildContext.register(theme)
        var copy = self
        copy.attributes.append(dataAttributes: .init(name: "inline-highlighter-theme", value: theme.id))
        return copy
    }

    /// Renders this element into HTML.
    /// - Returns: The HTML for this element.
    public func render() -> Markup {
        guard let language else {
            return Markup("<code\(attributes)>\(content.markupString())</code>")
        }

        BuildContext.register(language)
        var attributes = attributes
        attributes.append(classes: "language-\(language)")
        return Markup("<code\(attributes)>\(content)</code>")
    }
}
