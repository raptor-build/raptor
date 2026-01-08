//
// List.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

/// Creates a list of items, either ordered or unordered.
public struct List<Content: HTML>: HTML {
    /// The content and behavior of this HTML.
    public var body: Never { fatalError() }

    /// The standard set of control attributes for HTML elements.
    public var attributes = CoreAttributes()

    /// The current style for the list item markers. Defaults to `.unordered`.
    private var markerStyle: ListMarkerStyle = .unordered

    /// The items to show in this list. This may contain any page elements,
    /// but if you need specific styling you might want to use `ListItem` objects.
    private var content: Content

    /// Returns the correct HTML name for this list.
    private var listElementName: String {
        if case .ordered = markerStyle {
            "ol"
        } else {
            "ul"
        }
    }

    /// Creates a new `List` object using a page element builder that returns
    /// an array of `HTML` objects to display in the list.
    /// - Parameter items: The content you want to display in your list.
    public init(@HTMLBuilder content: () -> Content) {
        self.content = content()
    }

    /// Creates a new list from a collection of items, along with a function that converts
    /// a single object from the collection into a list item.
    /// - Parameters:
    ///   - items: A sequence of items you want to convert into list items.
    ///   - content: A function that accepts a single value from the sequence, and
    ///     returns an item representing that value in the list.
    public init<T, S: Sequence, RowContent: HTML>(
        _ items: S,
        @HTMLBuilder content: @escaping (T) -> RowContent
    ) where S.Element == T, Content == ForEach<[T], RowContent> {
        let content = ForEach(Array(items), content: content)
        self.content = content
    }

    /// Adjusts the style of the list item markers.
    /// - Parameter style: The new style.
    /// - Returns: A new `List` instance with the updated style.
    public func listMarkerStyle(_ style: ListMarkerStyle) -> Self {
        var copy = self
        copy.markerStyle = style
        return copy
    }

    /// Combines list and marker styles into a single `CoreAttributes` object for rendering.
    private var listAttributes: CoreAttributes {
        var attributes = attributes
        attributes.append(classes: "list")

        switch markerStyle {
        case .ordered(let style):
            attributes.append(classes: "list-ordered")
            attributes.append(styles: .variable("list-style-type", value: style.rawValue))

        case .unordered(let style):
            attributes.append(classes: "list-unordered")
            if style != .automatic {
                let symbol = unorderedCSSSymbol(for: style)
                attributes.append(styles: .variable("list-marker-content", value: "'\(symbol)'"))
            }

        case .custom(let symbol):
            attributes.append(classes: "list-custom")
            attributes.append(styles: .variable("list-marker-content", value: "'\(symbol)'"))
        }

        return attributes
    }

    private func unorderedCSSSymbol(for style: UnorderedListMarkerStyle) -> String {
        switch style {
        case .automatic: "•"
        case .circle:    "◦"
        case .square:    "▪"
        case .custom:    "•" // overridden by .custom case above
        }
    }

    /// Renders this element into HTML.
    /// - Returns: The HTML for this element.
    public func render() -> Markup {
        var html = "<\(listElementName)\(listAttributes)>"
        html += content.subviews().map { subview in
            var listItem = ListItem {
                Section(subview)
                    .class("list-row-content")
            }
            .class("list-row")
            if let id = subview.stableID,
               let context = BuildContext.current.listRowContexts[id] {
                listItem.attributes.append(styles: context.styles)
            }

            return listItem.markupString()
        }
        .joined()

        html += "</\(listElementName)>"
        return Markup(html)
    }
}
