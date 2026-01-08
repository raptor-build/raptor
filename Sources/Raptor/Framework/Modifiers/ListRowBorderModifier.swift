//
// ListRowBorderModifier.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

private struct ListRowBorderModifier: HTMLModifier {
    func body(content: Content) -> some HTML {
        content
    }
}

public extension HTML {
    /// Adds a border to this element.
    /// - Parameters:
    ///   - color: The color of the border
    ///   - width: The width in pixels
    ///   - style: The border style
    ///   - edges: Which edges should have borders
    /// - Returns: A modified element with the border applied
    func listRowBorder(
        _ color: Color,
        width: Double = 1,
        style: StrokeStyle = .solid,
        edges: Edge = .all
    ) -> some HTML {
        let modified = ModifiedHTML(content: self, modifier: ListRowBorderModifier())
        if let id = modified.stableID {
            let width = LengthUnit.px(width).css
            let cssValue = "\(width) \(style) \(color)"
            let styles = edges.edgeSet(variablePrefix: "list-row-border", value: cssValue)
            BuildContext.registerListRowBorder(id, styles)
        }
        return modified
    }
}

private struct ListRowBorderInlineModifier: InlineContentModifier {
    func body(content: Content) -> some InlineContent {
        content
    }
}

public extension InlineContent {
    /// Adds a border to this element.
    /// - Parameters:
    ///   - color: The color of the border
    ///   - width: The width in pixels
    ///   - style: The border style
    ///   - edges: Which edges should have borders
    /// - Returns: A modified element with the border applied
    func listRowBorder(
        _ color: Color,
        width: Double = 1,
        style: StrokeStyle = .solid,
        edges: Edge = .all
    ) -> some InlineContent {
        let modified = ModifiedInlineContent(content: self, modifier: ListRowBorderInlineModifier())
        if let id = modified.stableID {
            let width = LengthUnit.px(width).css
            let cssValue = "\(width) \(style) \(color)"
            let styles = edges.edgeSet(variablePrefix: "list-row-border", value: cssValue)
            BuildContext.registerListRowBorder(id, styles)
        }
        return modified
    }
}
