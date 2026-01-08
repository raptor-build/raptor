//
// Grid.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

/// A container that arranges its children in a two-dimensional layout.
///
/// A grid positions its content in rows and columns. When you provide an
/// explicit set of column sizes, the grid uses those definitions when laying
/// out its children. When no column sizes are provided, the grid infers its
/// column count from the row that contains the largest number of elements,
/// and you add content to the grid by grouping items into rows using `GridRow`.
///
/// ```swift
/// Grid {
///     GridRow {
///         Text("A")
///         Text("B")
///     }
///     Text("Full-width")
///         .gridCellColumns(2)
/// }
///
/// Grid(columns: [.flexible, .fixed(200)]) {
///     Text("A")
///     Text("B")
///     Text("C")
/// }
/// ```
///
/// You can customize spacing and alignment by providing values when
/// creating the grid.
public struct Grid<Content: HTML>: HTML {
    /// A resolved representation of a single grid row after layout inference.
    private struct ResolvedGridRow {
        /// The grid items contained in this row, in render order.
        let items: [AnyGridItem]

        /// Indicates whether this row represents implicit content that should span all columns.
        let isFullWidth: Bool
    }

    /// The content and behavior of this HTML.
    public var body: Never { fatalError() }

    /// The standard set of control attributes for HTML elements.
    public var attributes = CoreAttributes()

    /// The amount of space between elements.
    private var spacingAmount: SpacingAmount

    /// The alignment of the items within the grid.
    private var alignment: Alignment

    /// The number of columns this grid should span. When empty,
    /// the column count is based on the longest row.
    private var columnSizes = [GridItemSize]()

    /// The rows that make up the grid's content.
    private var content: Content

    /// The tag of this element.
    private var tag = "div"

    /// Creates a new grid where the number of columns is inferred
    /// automatically based on the row containing the largest number of children.
    /// - Parameters:
    ///   - alignment: The alignment of items within the grid. Defaults to `.center`.
    ///   - spacing: The number of pixels between each element.
    ///   - content: A closure returning the grid’s HTML content.
    public init(
        alignment: Alignment = .center,
        spacing: Double,
        @HTMLBuilder content: () -> Content
    ) {
        self.spacingAmount = .exact(spacing)
        self.alignment = alignment
        self.content = content()
    }

    /// Creates a new grid where the number of columns is inferred
    /// automatically based on the row containing the largest number of children.
    /// - Parameters:
    ///   - alignment: The alignment of items within the grid. Defaults to `.center`.
    ///   - spacing: A semantic spacing value between each element.
    ///   - content: A closure returning the grid’s HTML content.
    public init(
        alignment: Alignment = .center,
        spacing: SemanticSpacing = .medium,
        @HTMLBuilder content: () -> Content
    ) {
        self.spacingAmount = .semantic(spacing)
        self.alignment = alignment
        self.content = content()
    }

    /// Creates a new `Grid` object using a block element builder
    /// that returns an array of items to use in this grid.
    /// - Parameters:
    ///   - alignment: The alignment of items in the grid. Defaults to `.center`.
    ///   - spacing: The number of pixels between each element.
    ///   - items: The items to use in this grid.
    public init(
        columns: [GridItemSize],
        alignment: Alignment = .center,
        spacing: Double,
        @HTMLBuilder content: () -> Content
    ) {
        self.spacingAmount = .exact(spacing)
        self.alignment = alignment
        self.columnSizes = columns
        self.content = content()
    }

    /// Creates a new `Grid` object using a block element builder
    /// that returns an array of items to use in this grid.
    /// - Parameters:
    ///   - alignment: The alignment of items in the grid. Defaults to `.center`.
    ///   - spacing: The predefined size between each element. Defaults to `.none`.
    ///   - items: The items to use in this grid.
    public init(
        columns: [GridItemSize],
        alignment: Alignment = .center,
        spacing: SemanticSpacing = .medium,
        @HTMLBuilder content: () -> Content
    ) {
        self.spacingAmount = .semantic(spacing)
        self.alignment = alignment
        self.columnSizes = columns
        self.content = content()
    }

    /// Creates a new grid from a collection of items, along with a function that converts
    /// a single object from the collection into one grid column.
    /// - Parameters:
    ///   - items: A sequence of items you want to convert into columns.
    ///   - alignment: The alignment of items in the grid. Defaults to `.center`.
    ///   - spacing: The number of pixels between each element.
    ///   - content: A function that accepts a single value from the sequence, and
    ///     returns some HTML representing that value in the grid.
    public init<T, S: Sequence, ItemContent: HTML>(
        _ items: S,
        columns: [GridItemSize],
        alignment: Alignment = .center,
        spacing: Double,
        @HTMLBuilder content: @escaping (T) -> ItemContent
    ) where S.Element == T, Content == ForEach<[T], ItemContent> {
        self.spacingAmount = .exact(spacing)
        self.alignment = alignment
        self.columnSizes = columns
        let content = ForEach(Array(items), content: content)
        self.content = content
    }

    /// Creates a new grid from a collection of items, along with a function that converts
    /// a single object from the collection into one grid column.
    /// - Parameters:
    ///   - items: A sequence of items you want to convert into columns.
    ///   - alignment: The alignment of items in the grid. Defaults to `.center`.
    ///   - spacing: The number of pixels between each element.
    ///   - content: A function that accepts a single value from the sequence, and
    ///     returns some HTML representing that value in the grid.
    public init<T, S: Sequence, ItemContent: HTML>(
        _ items: S,
        alignment: Alignment = .center,
        spacing: Double,
        @HTMLBuilder content: @escaping (T) -> ItemContent
    ) where S.Element == T, Content == ForEach<[T], ItemContent> {
        self.spacingAmount = .exact(spacing)
        self.alignment = alignment
        let content = ForEach(Array(items), content: content)
        self.content = content
    }

    /// Creates a new grid from a collection of items, along with a function that converts
    /// a single object from the collection into one grid column.
    /// - Parameters:
    ///   - items: A sequence of items you want to convert into columns.
    ///   - alignment: The alignment of items in the grid. Defaults to `.center`.
    ///   - spacing: The predefined size between each element. Defaults to `.none`
    ///   - content: A function that accepts a single value from the sequence, and
    ///     returns some HTML representing that value in the grid.
    public init<T, S: Sequence, ItemContent: HTML>(
        _ items: S,
        columns: [GridItemSize],
        alignment: Alignment = .center,
        spacing: SemanticSpacing = .medium,
        @HTMLBuilder content: @escaping (T) -> ItemContent
    ) where S.Element == T, Content == ForEach<[T], ItemContent> {
        self.spacingAmount = .semantic(spacing)
        self.alignment = alignment
        self.columnSizes = columns
        let content = ForEach(Array(items), content: content)
        self.content = content
    }

    /// Creates a new grid from a collection of items, along with a function that converts
    /// a single object from the collection into one grid column.
    /// - Parameters:
    ///   - items: A sequence of items you want to convert into columns.
    ///   - alignment: The alignment of items in the grid. Defaults to `.center`.
    ///   - spacing: The predefined size between each element. Defaults to `.none`
    ///   - content: A function that accepts a single value from the sequence, and
    ///     returns some HTML representing that value in the grid.
    public init<T, S: Sequence, ItemContent: HTML>(
        _ items: S,
        alignment: Alignment = .center,
        spacing: SemanticSpacing = .medium,
        @HTMLBuilder content: @escaping (T) -> ItemContent
    ) where S.Element == T, Content == ForEach<[T], ItemContent> {
        self.spacingAmount = .semantic(spacing)
        self.alignment = alignment
        let content = ForEach(Array(items), content: content)
        self.content = content
    }

    /// Marks this view as a `<form>` element.
    /// - Parameter isForm: When true (default), the element is rendered as a `<form>`.
    /// - Returns: A modified view whose tag is `"form"`.
    func isForm(_ isForm: Bool = true) -> Self {
        var copy = self
        copy.tag = "form"
        return copy
    }

    /// Renders this element into HTML.
    /// - Returns: The HTML for this element.
    public func render() -> Markup {
        let rows = resolveRows()
        let maxColumns = computeMaxColumns(from: rows)
        let items = flattenRows(rows, maxColumns: maxColumns)
        let template = buildGridTemplate(columnCount: maxColumns)

        return Tag(tag) {
            ForEach(items) { item in
                item.class("grid-item")
            }
        }
        .attributes(attributes)
        .class("grid")
        .style(.variable("grid-template", value: template))
        .style(spacingAmount.inlineStyle)
        .style(alignment.gridAlignmentRules)
        .render()
    }

    /// Resolves the grid’s content into explicit and implicit rows.
    private func resolveRows() -> [ResolvedGridRow] {
        content.subviews().map { subview in
            if let row = subview.wrapped as? any GridRowProvider {
                .init(items: row.gridItems(), isFullWidth: false)
            } else {
                .init(items: [AnyGridItem(subview.wrapped)], isFullWidth: true)
            }
        }
    }

    /// Computes the maximum number of columns required by the grid.
    private func computeMaxColumns(from rows: [ResolvedGridRow]) -> Int {
        rows.map { row in
            row.items.reduce(0) { $0 + max($1.columnSpan, 1) }
        }
        .max() ?? 1
    }

    /// Applies full-width spans to implicit rows and flattens all items.
    private func flattenRows(_ rows: [ResolvedGridRow], maxColumns: Int) -> [AnyGridItem] {
        rows.map { row in
            guard row.isFullWidth, var item = row.items.first else {
                return row
            }

            item.columnSpan = maxColumns
            return ResolvedGridRow(items: [item], isFullWidth: true)
        }
        .flatMap(\.items)
    }

    /// Builds the CSS grid template string for the grid.
    private func buildGridTemplate(columnCount: Int) -> String {
        columnSizes.isEmpty
            ? Array(repeating: GridItemSize.flexible.css, count: columnCount).joined(separator: " ")
            : columnSizes.map(\.css).joined(separator: " ")
    }
}
