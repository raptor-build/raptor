//
// ListRowCornerRadiusModifier.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

private struct ListRowCornerRadiusModifier: HTMLModifier {
    func body(content: Content) -> some HTML {
        content
    }
}

public extension HTML {
    /// Sets the corner radius for all edges of the list row containing this element.
    /// - Parameter radius: The corner radius in pixels.
    /// - Returns: A modified element defining a row-level corner radius.
    func listRowCornerRadius(_ radius: Int) -> some HTML {
        listRowCornerRadius(.all, radius, style: .round)
    }

    /// Sets the corner radius for all edges of the list row containing this element.
    /// - Parameters:
    ///   - radius: The corner radius in pixels.
    ///   - style: The corner rendering style.
    /// - Returns: A modified element defining a row-level corner radius.
    func listRowCornerRadius(_ radius: Int, style: CornerStyle) -> some HTML {
        listRowCornerRadius(.all, radius, style: style)
    }

    /// Sets the corner radius for selected edges of the list row containing this element.
    /// - Parameters:
    ///   - edges: Which corners should be rounded.
    ///   - radius: The corner radius in pixels.
    /// - Returns: A modified element defining a row-level corner radius.
    func listRowCornerRadius(
        _ edges: DiagonalEdge,
        _ radius: Int
    ) -> some HTML {
        listRowCornerRadius(edges, radius, style: .round)
    }

    /// Sets the corner radius for selected edges of the list row containing this element.
    /// - Parameters:
    ///   - edges: Which corners should be rounded.
    ///   - radius: The corner radius in pixels.
    ///   - style: The corner rendering style.
    /// - Returns: A modified element defining a row-level corner radius.
    func listRowCornerRadius(
        _ edges: DiagonalEdge,
        _ radius: Int,
        style: CornerStyle
    ) -> some HTML {
        let modified = ModifiedHTML(content: self, modifier: ListRowCornerRadiusModifier())
        if let id = modified.stableID {
            let styles = edges.cornerSet(variablePrefix: "list-row-radius", value: "\(radius)px")
            BuildContext.registerListRowCornerRadius(id, styles)
        }
        return modified
    }
}

private struct ListRowCornerRadiusInlineModifier: InlineContentModifier {
    func body(content: Content) -> some InlineContent {
        content
    }
}

public extension InlineContent {

    /// Sets the corner radius for all edges of the list row containing this inline element.
    /// - Parameter radius: The corner radius in pixels.
    /// - Returns: A modified inline element defining a row-level corner radius.
    func listRowCornerRadius(_ radius: Int) -> some InlineContent {
        listRowCornerRadius(.all, radius, style: .round)
    }

    /// Sets the corner radius for all edges of the list row containing this inline element.
    /// - Parameters:
    ///   - radius: The corner radius in pixels.
    ///   - style: The corner rendering style.
    /// - Returns: A modified inline element defining a row-level corner radius.
    func listRowCornerRadius(_ radius: Int, style: CornerStyle) -> some InlineContent {
        listRowCornerRadius(.all, radius, style: style)
    }

    /// Sets the corner radius for selected edges of the list row containing this inline element.
    /// - Parameters:
    ///   - edges: Which corners should be rounded.
    ///   - radius: The corner radius in pixels.
    /// - Returns: A modified inline element defining a row-level corner radius.
    func listRowCornerRadius(
        _ edges: DiagonalEdge,
        _ radius: Int
    ) -> some InlineContent {
        listRowCornerRadius(edges, radius, style: .round)
    }

    /// Sets the corner radius for selected edges of the list row containing this inline element.
    /// - Parameters:
    ///   - edges: Which corners should be rounded.
    ///   - radius: The corner radius in pixels.
    ///   - style: The corner rendering style.
    /// - Returns: A modified inline element defining a row-level corner radius.
    func listRowCornerRadius(
        _ edges: DiagonalEdge,
        _ radius: Int,
        style: CornerStyle
    ) -> some InlineContent {
        let modified = ModifiedInlineContent(content: self, modifier: ListRowCornerRadiusInlineModifier())
        if let id = modified.stableID {
            let styles = edges.cornerSet(variablePrefix: "list-row-radius", value: "\(radius)px")
            BuildContext.registerListRowCornerRadius(id, styles)
        }
        return modified
    }
}
