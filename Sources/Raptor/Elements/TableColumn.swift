//
// Column.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

/// A column inside a table row.
public struct TableColumn<Content: HTML>: HTML {
    /// The content and behavior of this HTML.
    public var body: Never { fatalError() }

    /// The standard set of control attributes for HTML elements.
    public var attributes = CoreAttributes()

    /// How many columns this should occupy when placed in a grid.
    private var columnSpan = 1

    /// How the contents of this column should be aligned.
    /// Defaults to `.top`.
    private var alignment = Alignment.topLeading

    /// The items to render inside this column.
    private var content: Content

    /// Creates a new table column with optional vertical alignment.
    /// - Parameter content: A view builder that produces the content of the column.
    public init(@HTMLBuilder content: () -> Content) {
        self.content = content()
    }

    /// Adjusts how many columns in a row this column should span.
    /// - Parameter columns: The number of columns to span
    /// - Returns: A new `TableColumn` instance with the updated column span.
    public func tableCellColumns(_ columns: Int) -> Self {
        var copy = self
        copy.columnSpan = columns
        return copy
    }

    /// Adjusts the alignment of the cells in this table column.
    /// - Parameter alignment: The new alignment.
    /// - Returns: A new `TableColumn` instance with the updated alignment.
    public func alignment(_ alignment: Alignment) -> Self {
        var copy = self
        copy.alignment = alignment
        return copy
    }

    /// Renders this element into HTML.
    /// - Returns: The HTML for this element.
    public func render() -> Markup {
        var columnAttributes = attributes

        columnAttributes.append(styles: alignment.tableCellAlignmentRules)
        columnAttributes.append(customAttributes: .init(name: "colspan", value: columnSpan.formatted()))
        let contentHTML = content.markupString()
        return Markup("<td\(columnAttributes)>\(contentHTML)</td>")
    }
}

extension TableColumn: ColumnProvider {}
