//
// Table.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

/// Used to create tabulated data on a page.
public struct Table<Header: InlineContent, Rows: HTML>: HTML {
    /// The content and behavior of this HTML.
    public var body: Never { fatalError() }

    /// The standard set of control attributes for HTML elements.
    public var attributes = CoreAttributes()

    /// What text to use for an optional filter text field.
    private var filterTitle: String?

    /// The rows that are inside this table.
    private var rows: Rows

    /// An optional array of header to use at the top of this table.
    private var header: Header

    /// The styling to apply to this table. Defaults to `.plain`.
    private var style = TableStyle.automatic

    /// An optional caption for this table. Displayed to the user, but also useful
    /// for screen readers so users can decide if the table is worth reading further.
    private var caption: String?

    /// Creates a new `Table` instance from an element builder that returns
    /// an array of rows to use in the table.
    /// - Parameters:
    ///   - filterTitle: When provided, this is used to for the placeholder in a
    ///     text field that filters the table data.
    ///   - rows: An array of rows to use in the table.
    public init<C>(
        filterTitle filterTitleKey: String? = nil,
        @TableContentBuilder rows: () -> C
    ) where Rows == TableContentBuilder.Content<C>, C: TableContent, Header == EmptyInlineContent {
        self.header = EmptyInlineContent()
        self.rows = TableContentBuilder.Content(rows())
        if let filterTitleKey {
            self.filterTitle = Localizer.string(filterTitleKey, locale: Self.locale)
        }
    }

    /// Creates a new `Table` instance from an element builder that returns
    /// an array of rows to use in the table, and also a page element builder
    /// that returns an array of headers to use at the top of the table.
    /// - Parameters:
    ///   - filterTitle: When provided, this is used to for the placeholder in a
    ///     text field that filters the table data.
    ///   - rows: An array of rows to use in the table.
    ///   - header: An array of headers to use at the top of the table.
    public init<C>(
        filterTitle filterTitleKey: String? = nil,
        @TableContentBuilder rows: () -> C,
        @InlineContentBuilder header: () -> Header
    ) where Rows == TableContentBuilder.Content<C>, C: TableContent, Header == EmptyInlineContent {
        self.rows = TableContentBuilder.Content(rows())
        self.header = header()
        if let filterTitleKey {
            self.filterTitle = Localizer.string(filterTitleKey, locale: Self.locale)
        }
    }

    /// Creates a new `Table` instance from a collection of items, along with a function
    /// that converts a single object from the collection into one row in the table.
    /// - Parameters:
    ///   - items: A sequence of items you want to convert into rows.
    ///   - filterTitle: When provided, this is used to for the placeholder in a
    ///     text field that filters the table data.
    ///   - content: A function that accepts a single value from the sequence, and
    /// returns a row representing that value in the table.
    public init<C, T, S: Sequence>(
        _ items: S,
        filterTitle filterTitleKey: String? = nil,
        @TableContentBuilder rows: @escaping (T) -> C
    ) where
        S.Element == T,
        Header == EmptyInlineContent,
        Rows == TableContentBuilder.Content<TableRowForEach<[T], C>>,
        C: TableContent
    { // swiftlint:disable:this opening_brace
        let content = TableRowForEach(Array(items), content: rows)
        self.rows = TableContentBuilder.Content(content)
        self.header = EmptyInlineContent()
        if let filterTitleKey {
            self.filterTitle = Localizer.string(filterTitleKey, locale: Self.locale)
        }
    }

    /// Creates a new `Table` instance from a collection of items, along with a function
    /// that converts a single object from the collection into one row in the table.
    /// - Parameters:
    ///   - items: A sequence of items you want to convert into rows.
    ///   - filterTitle: When provided, this is used to for the placeholder in a
    ///     text field that filters the table data.
    ///   - content: A function that accepts a single value from the sequence, and
    ///     returns a row representing that value in the table.
    ///   - header: An array of headers to use at the top of the table.
    public init<C, T, S: Sequence>(
        _ items: S,
        filterTitle filterTitleKey: String? = nil,
        @TableContentBuilder rows: @escaping (T) -> C,
        @InlineContentBuilder header: () -> Header
    ) where
        S.Element == T,
        Rows == TableContentBuilder.Content<TableRowForEach<Array<T>, C>>,
        C: TableContent
    { // swiftlint:disable:this opening_brace
        let content = TableRowForEach(Array(items), content: rows)
        self.rows = TableContentBuilder.Content(content)
        self.header = header()
        if let filterTitleKey {
            self.filterTitle = Localizer.string(filterTitleKey, locale: Self.locale)
        }
    }

    /// Adjusts the style of this table.
    /// - Parameter style: The new style.
    /// - Returns: A new `Table` instance with the updated style.
    public func tableStyle(_ style: TableStyle) -> Self {
        var copy = self
        copy.style = style
        return copy
    }

    /// Updates the caption for this table to a different string.
    /// - Parameter label: The new accessibility label.
    /// - Returns: A new `Table` instance with the updated accessibility label.
    public func caption(_ label: String) -> Self {
        var copy = self
        copy.caption = label
        return copy
    }

    /// Produces the CSS variable used to control table corner rounding
    /// based on the table’s configured corner style.
    private func radius(for corners: TableStyle.TableRowCornerStyle) -> Property {
        switch corners {
        case .square: .variable("table-cell-radius", value: "0px")
        case .rounded(let radius): .variable("table-cell-radius", value: "\(radius)px")
        }
    }

    /// Renders this element into HTML.
    /// - Returns: The HTML for this element.
    public func render() -> Markup {
        var tableAttributes = attributes.appending(classes: ["table"])

        switch style {
        case .stripedRows(let corners):
            tableAttributes.append(classes: ["table-striped-rows"])
            tableAttributes.append(styles: radius(for: corners))

        case .stripedColumns(let corners):
            tableAttributes.append(classes: ["table-striped-columns"])
            tableAttributes.append(styles: radius(for: corners))

        case .plain:
            break
        }

        var output = ""

        if let filterTitle {
            tableAttributes.id = "table-\(UUID().uuidString.truncatedHash)"
            output += """
            <input class=\"filter-field mb-2\" type=\"text\" \
            placeholder=\"\(filterTitle)\" \
            onkeyup=\"raptorFilterTable(this.value, '\(tableAttributes.id)')\">
            """
        }

        if header.isEmptyContent == false {
            tableAttributes.append(classes: "header-table")
        }

        output += "<table\(tableAttributes)>"

        if let caption {
            output += "<caption>\(caption)</caption>"
        }

        if header.isEmptyContent == false {
            let headerHTML = header.subviews().map { cell in
                // Since raw text cannot be styled, we need to wrap it in a <span>.
                let resolved: any InlineContent = if cell.wrapped is String {
                    InlineText(cell)
                } else {
                    cell
                }
                return "<th>\(resolved.markupString())</th>"
            }.joined()
            output += "<thead><tr>\(headerHTML)</tr></thead>"
        }

        output += "<tbody>"
        output += rows.render().string
        output += "</tbody>"
        output += "</table>"
        return Markup(output)
    }
}
