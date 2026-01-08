//
// ListRowPaddingModifier.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

/// A modifier used internally to mark an element as having list-row padding.
/// Styling is applied later by the `List` renderer through CSS variables.
private struct ListRowInsetsModifier: HTMLModifier {
    func body(content: Content) -> some HTML {
        content
    }
}

public extension HTML {
    /// Defines per-side padding for the list row that contains this element.
    /// - Parameter amount: The padding amount in pixels applied to all sides.
    /// - Returns: A modified element whose list-row padding will be applied
    ///   only when rendered inside a `List`.
    func listRowInsets(_ amount: Int) -> some HTML {
        listRowInsets(.all, amount)
    }

    /// Defines per-side padding for the list row that contains this element.
    /// - Parameters:
    ///   - edges: The specific edges (e.g., `.top`, `.vertical`) to apply.
    ///   - amount: The padding amount in pixels.
    /// - Returns: A modified element whose list-row padding will be applied
    ///   only when rendered inside a `List`.
    func listRowInsets(_ edges: Edge, _ amount: Int) -> some HTML {
        let modified = ModifiedHTML(content: self, modifier: ListRowInsetsModifier())
        if let id = modified.stableID {
            let styles = edges.edgeSet(variablePrefix: "list-row-padding", value: "\(amount)px")
            BuildContext.registerListRowPadding(id, styles)
        }
        return modified
    }
}

/// A modifier used internally to mark an inline element as having
/// list-row padding. Rendering is handled by the parent `List`.
private struct ListRowInsetsInlineModifier: InlineContentModifier {
    func body(content: Content) -> some InlineContent {
        content
    }
}

public extension InlineContent {
    /// Defines padding for the list row that contains this inline element.
    /// - Parameter amount: The padding amount in pixels applied to all sides.
    /// - Returns: A modified inline element with deferred list-row padding.
    func listRowInsets(_ amount: Int) -> some InlineContent {
        listRowInsets(.all, amount)
    }

    /// Defines per-side padding for the list row that contains this inline element.
    /// - Parameters:
    ///   - edges: Which edges the padding applies to.
    ///   - amount: The padding amount in pixels.
    /// - Returns: A modified inline element with deferred list-row padding.
    func listRowInsets(_ edges: Edge, _ amount: Int) -> some InlineContent {
        let modified = ModifiedInlineContent(content: self, modifier: ListRowInsetsInlineModifier())
        if let id = modified.stableID {
            let styles = edges.edgeSet(variablePrefix: "list-row-padding", value: "\(amount)px")
            BuildContext.registerListRowPadding(id, styles)
        }
        return modified
    }
}
