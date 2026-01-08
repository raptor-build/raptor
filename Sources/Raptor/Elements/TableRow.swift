//
// Row.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

/// One row inside a `Table`.
public struct TableRow<Content: HTML>: TableContent {
    /// The content and behavior of this HTML.
    public var body: Never { fatalError() }

    /// The standard set of control attributes for HTML elements.
    public var attributes = CoreAttributes()

    /// The columns to display inside this row.
    private var columns: Content

    /// Create a new `Row` using a page element builder that returns the
    /// array of columns to use in this row.
    /// - Parameter columns: The columns to use in this row.
    public init(@HTMLBuilder columns: () -> Content) {
        self.columns = columns()
    }

    /// Sets the tint color for the separator following this row.
    /// - Parameter color: The color to apply to the row’s separator.
    /// - Returns: A modified row with the updated separator tint.
    public func tableRowSeparatorTint(_ color: Color) -> Self {
        var copy = self
        copy.attributes.append(styles: .variable("table-separator-color", value: color.description))
        return copy
    }

    /// Aligns multiline text within this element.
    /// - Parameter alignment: The text alignment to apply.
    /// - Returns: A modified copy of this element with text alignment applied.
    public func multilineTextAlignment(_ alignment: TextAlignment) -> Self {
        var copy = self
        copy.attributes.append(styles: alignment.style)
        return copy
    }

    /// Renders this element into HTML.
    /// - Returns: The HTML for this element.
    public func render() -> Markup {
        let output = columns.subviews().map { column in
            if column.wrapped is any ColumnProvider {
                column.render()
            } else {
                Markup("<td>\(column.markupString())</td>")
            }
        }.joined()

        return Markup("<tr\(attributes)>\(output.string)</tr>")
    }
}
