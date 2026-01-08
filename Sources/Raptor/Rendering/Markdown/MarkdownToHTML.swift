//
// MarkdownToHTML.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

import Foundation
import Markdown

/// A simple Markdown to HTML processor powered by Apple's swift-markdown.
public struct MarkdownToHTML: PostProcessor, MarkupVisitor {
    /// The title of this document.
    private var title = ""

    /// The description of this document, which is the first paragraph.
    private var description = ""

    /// Whether to remove the Markdown title from its body. This only applies
    /// to the first heading.
    public var removeTitleFromBody = true

    /// The syntax highlighters required by the processor.
    public var syntaxHighlighterLanguages = Set<SyntaxHighlighterLanguage>()

    /// Whether inline code should use syntax highlighting.
    public var highlightInlineCode = false

    /// The syntax highlighters preferences of the processor.
    lazy public var syntaxHighlighterConfiguration: SyntaxHighlighterConfiguration? = {
        let site = RenderingContext.current?.site
        return site?.syntaxHighlighterConfiguration
    }()

    /// Initializes a renderer with default values.
    public init() {}

    public mutating func process(_ markup: String) -> ProcessedPost {
        let document = Markdown.Document(parsing: markup)
        let body = visit(document)
        return ProcessedPost(title: title, description: description, body: body)
    }

    /// Visit some markup when no other handler is suitable.
    /// - Parameter markup: The markup that is being processed.
    /// - Returns: A string to append to the output.
    public mutating func defaultVisit(_ markup: Markdown.Markup) -> String {
        var result = ""

        for child in markup.children {
            result += visit(child)
        }

        return result
    }

    /// Processes block quote markup.
    /// - Parameter blockQuote: The block quote data to process.
    /// - Returns: A HTML <blockquote> element with the block quote's children inside.
    public mutating func visitBlockQuote(_ blockQuote: Markdown.BlockQuote) -> String {
        var result = "<blockquote>"

        for child in blockQuote.children {
            result += visit(child)
        }

        result += "</blockquote>"
        return result
    }

    /// Processes code block markup.
    /// - Parameter codeBlock: The code block to process.
    /// - Returns: A HTML <pre> element with <code> inside, marked with
    /// CSS to remember which language was used.
    public mutating func visitCodeBlock(_ codeBlock: Markdown.CodeBlock) -> String {
        var preAttributes = CoreAttributes()
        var codeAttributes = CoreAttributes()

        if syntaxHighlighterConfiguration?.lineWrapping == .enabled {
            preAttributes.append(styles: .whiteSpace(.preWrap))
        }

        if syntaxHighlighterConfiguration?.whitespaceCharacterVisibility == .visible {
            preAttributes.append(classes: "show-invisibles")
        }

        if let language = codeBlock.language {
            if let highlighter = SyntaxHighlighterLanguage(rawValue: language) {
                syntaxHighlighterLanguages.insert(highlighter)
            }
            codeAttributes.append(classes: "language-\(language.lowercased())")
        } else if let defaultLanguage = syntaxHighlighterConfiguration?.defaultLanguage {
            codeAttributes.append(classes: "language-\(defaultLanguage.rawValue.lowercased())")
        }

        return "<pre\(preAttributes)><code\(codeAttributes)>\(codeBlock.code)</code></pre>"
    }

    /// Processes soft breaks (single newlines).
    /// - Parameter softBreak: The soft break to process.
    /// - Returns: A single space.
    public func visitSoftBreak(_ softBreak: SoftBreak) -> String {
        " "
    }

    /// Processes hard line breaks (lines ending with 2 spaces or a backslash).
    /// - Parameter lineBreak: The line break to process.
    /// - Returns: A HTML <br /> tag.
    public func visitLineBreak(_ lineBreak: LineBreak) -> String {
        "<br />"
    }

    /// Processes emphasis markup.
    /// - Parameter emphasis: The emphasized content to process.
    /// - Returns: A HTML <em> element with the markup's children inside.
    public mutating func visitEmphasis(_ emphasis: Markdown.Emphasis) -> String {
        var result = "<em>"

        for child in emphasis.children {
            result += visit(child)
        }

        result.append("</em>")
        return result
    }

    /// Processes heading markup.
    /// - Parameter heading: The heading to process.
    /// - Returns: A HTML <h*> element with its children inside. The heading
    /// level depends on the markup. The first heading is used for the document title.
    public mutating func visitHeading(_ heading: Markdown.Heading) -> String {
        var headingContent = ""

        for child in heading.children {
            headingContent += visit(child)
        }

        // If we don't already have a document title, use this as the document's title.
        if heading.level == 1, title.isEmpty {
            title = headingContent

            // If we're stripping the title from the rendered body, send back nothing here.
            if removeTitleFromBody {
                return ""
            }
        }

        return "<h\(heading.level)>\(headingContent)</h\(heading.level)>"
    }

    /// Processes a block of HTML markup.
    /// - Parameter html: The HTML to process.
    /// - Returns: The raw HTML as-is.
    public func visitHTMLBlock(_ html: Markdown.HTMLBlock) -> String {
        html.rawHTML
    }

    /// Process image markup.
    /// - Parameter image: The image markup to process.
    /// - Returns: A HTML <img> tag with its source set correctly.
    public func visitImage(_ image: Markdown.Image) -> String {
        if let source = image.source {
            let title = image.plainText
            return #"<img src="\#(source)" alt="\#(title)" class="img-resizable">"#
        } else {
            return ""
        }
    }

    /// Processes inline code markup.
    /// - Parameter inlineCode: The inline code markup to process.
    /// - Returns: A HTML `<code>` element containing the code.
    /// If inline code highlighting is enabled, a language class will be applied.
    public mutating func visitInlineCode(_ inlineCode: Markdown.InlineCode) -> String {
        if highlightInlineCode, let defaultHighlighter = syntaxHighlighterConfiguration?.defaultLanguage {
            #"<code class="language-\#(defaultHighlighter)">\#(inlineCode.code)</code>"#
        } else {
            "<code>\(inlineCode.code)</code>"
        }
    }

    /// Processes a chunk of inline HTML markup.
    /// - Parameter inlineHTML: The HTML markup to process.
    /// - Returns: The raw HTML as-is.
    public func visitInlineHTML(_ inlineHTML: Markdown.InlineHTML) -> String {
        inlineHTML.rawHTML
    }

    /// Processes hyperlink markup.
    /// - Parameter link: The link markup to process.
    /// - Returns: Returns a HTML <a> tag with the correct location and content.
    public mutating func visitLink(_ link: Markdown.Link) -> String {
        var result = #"<a href="\#(link.destination ?? "#")">"#

        for child in link.children {
            result += visit(child)
        }

        result += "</a>"
        return result
    }

    /// Processes one item from a list.
    /// - Parameter listItem: The list item markup to process.
    /// - Returns: A HTML <li> tag containing the list item's contents.
    public mutating func visitListItem(_ listItem: Markdown.ListItem) -> String {
        var result = "<li>"

        for child in listItem.children {
            result += visit(child)
        }

        result += "</li>"
        return result
    }

    /// Processes unordered list markup.
    /// - Parameter orderedList: The unordered list markup to process.
    /// - Returns: A HTML <ol> element with the correct contents.
    public mutating func visitOrderedList(_ orderedList: Markdown.OrderedList) -> String {
        var result = "<ol>"

        for listItem in orderedList.listItems {
            result += visit(listItem)
        }

        result += "</ol>"
        return result
    }

    /// Processes a paragraph of text.
    /// - Parameter paragraph: The paragraph markup to process.
    /// - Returns: If we're inside a list this sends back the paragraph's
    /// contents. Otherwise, it wraps the contents in a HTML <p> element.
    /// The first paragraph in the document is used for the document description.
    public mutating func visitParagraph(_ paragraph: Markdown.Paragraph) -> String {
        var result = ""
        var paragraphContents = ""

        if paragraph.isInsideList == false {
            result += "<p>"
        }

        for child in paragraph.children {
            paragraphContents += visit(child)
        }

        result += paragraphContents

        if description.isEmpty {
            description = paragraphContents
        }

        if paragraph.isInsideList == false {
            result += "</p>"
        }

        return result
    }

    /// Processes some strikethrough markup.
    /// - Parameter strikethrough: The strikethrough markup to process.
    /// - Returns: Content wrapped inside a HTML <s> element.
    public mutating func visitStrikethrough(_ strikethrough: Markdown.Strikethrough) -> String {
        var result = "<s>"

        for child in strikethrough.children {
            result += visit(child)
        }

        result += "</s>"

        return result
    }

    /// Processes some strong markup.
    /// - Parameter strong: The strong markup to process.
    /// - Returns: Content wrapped inside a HTML <strong> element.
    public mutating func visitStrong(_ strong: Markdown.Strong) -> String {
        var result = "<strong>"

        for child in strong.children {
            result += visit(child)
        }

        result += "</strong>"
        return result
    }

    /// Processes table markup.
    /// - Parameter table: The table markup to process.
    /// - Returns: A HTML <table> element, with <thead> and
    /// <tbody> if they are provided.
    public mutating func visitTable(_ table: Markdown.Table) -> String {
        var output = "<table>"

        if table.head.childCount > 0 {
            output += "<thead>"
            output += visit(table.head)
            output += "</thead>"
        }

        if table.body.childCount > 0 {
            output += "<tbody>"
            output += visit(table.body)
            output += "</tbody>"
        }

        output += "</table>"
        return output
    }

    /// Processes table head markup.
    /// - Parameter tableHead: The table head markup to process.
    /// - Returns: A string containing zero or more HTML <th> elements
    /// representing the headers in this table.
    public mutating func visitTableHead(_ tableHead: Markdown.Table.Head) -> String {
        var output = ""

        for child in tableHead.children {
            output += "<th scope=\"col\">"
            output += visit(child)
            output += "</th>"
        }

        return output
    }

    /// Processes table row markup.
    /// - Parameter tableRow: The table head markup to process.
    /// - Returns: A string containing zero or more HTML <tr> elements
    /// representing the rows in this table, with each row containing zero or
    /// more <td> elements for each column processed.
    public mutating func visitTableRow(_ tableRow: Markdown.Table.Row) -> String {
        var output = "<tr>"

        for child in tableRow.children {
            output += "<td>"
            output += visit(child)
            output += "</td>"
        }

        output += "</tr>"
        return output
    }

    /// Processes plain text markup.
    /// - Parameter text: The plain text markup to process.
    /// - Returns: The same text that was read as input.
    public mutating func visitText(_ text: Markdown.Text) -> String {
        text.plainText
    }

    /// Process thematic break markup. This is written as --- in Markdown.
    /// - Parameter thematicBreak: The thematic break markup to process.
    /// - Returns: A HTML <hr> element.
    public func visitThematicBreak(_ thematicBreak: Markdown.ThematicBreak) -> String {
        "<hr />"
    }

    /// Processes ordered list markup.
    /// - Parameter unorderedList: The unordered list markup to process.
    /// - Returns: A HTML <ul> element with the correct contents.
    public mutating func visitUnorderedList(_ unorderedList: Markdown.UnorderedList) -> String {
        var result = "<ul>"

        for listItem in unorderedList.listItems {
            result += visit(listItem)
        }

        result += "</ul>"
        return result
    }
}
