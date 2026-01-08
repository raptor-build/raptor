//
// ListRowMarginModifier.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

/// A modifier used internally to mark an element as having list-row margin.
/// The values are recorded during rendering and applied by the parent `List`.
private struct ListRowSpacingModifier: HTMLModifier {
    func body(content: Content) -> some HTML {
        content
    }
}

public extension HTML {
    /// Sets the bottom margin for the list row containing this inline element.
    /// - Parameter amount: The margin amount in pixels applied to bottom of the row.
    /// - Returns: A modified element whose margin will be applied by the parent `List`.
    func listRowSpacing(_ amount: Double) -> some HTML {
        let modified = ModifiedHTML(content: self, modifier: ListRowSpacingModifier())

        if let id = modified.stableID {
            BuildContext.registerListRowSpacing(id, amount)
        }

        return modified
    }
}

/// A modifier used internally to track margin on inline elements.
/// Actual layout is handled by the parent `List` during rendering.
private struct ListRowSpacingInlineModifier: InlineContentModifier {
    func body(content: Content) -> some InlineContent {
        content
    }
}

public extension InlineContent {
    /// Sets the bottom margin for the list row containing this inline element.
    /// - Parameter amount: The margin amount in pixels applied to bottom of the row.
    /// - Returns: A modified inline element whose margin is recorded for list rendering.
    func listRowSpacing(_ amount: Double) -> some InlineContent {
        let modified = ModifiedInlineContent(content: self, modifier: ListRowSpacingInlineModifier())
        if let id = modified.stableID {
            BuildContext.registerListRowSpacing(id, amount)
        }

        return modified
    }
}
