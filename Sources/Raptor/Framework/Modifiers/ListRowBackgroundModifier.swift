//
// ListRowBackgroundModifier.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

/// A lightweight marker modifier that tags this element as requesting
/// a list-row background. The actual styling is applied later by the
/// parent `List` during rendering.
private struct ListRowBackgroundModifier: HTMLModifier {
    func body(content: Content) -> some HTML {
        content
    }
}

public extension HTML {
    /// Specifies the background color that should be applied to the entire list row.
    /// - Parameter color: The background color to use for the row.
    /// - Returns: A modified version of this element that carries background
    ///   metadata used by list rendering.
    func listRowBackground(_ color: Color) -> some HTML {
        // This implementation works well for typical list items, but ForEach
        // won’t automatically pass the value down to each generated child.
        // Applying the modifier directly to each child remains the simplest
        // workaround without redesigning Raptor’s internals.
        let modified = ModifiedHTML(content: self, modifier: ListRowBackgroundModifier())
        if let id = modified.stableID {
            BuildContext.registerListRowBackground(id, color)
        }
        return modified
    }
}

/// Inline-element equivalent of `ListRowBackgroundModifier`, used when
/// the background is applied to inline content inside list rows.
private struct ListRowBackgroundInlineModifier: InlineContentModifier {
    func body(content: Content) -> some InlineContent {
        content
    }
}

public extension InlineContent {
    /// Specifies the background color that should be applied to the entire list row.
    /// - Parameter color: The background color to apply to the row.
    /// - Returns: A modified inline element carrying row-background metadata.
    func listRowBackground(_ color: Color) -> some InlineContent {
        let modified = ModifiedInlineContent(content: self, modifier: ListRowBackgroundInlineModifier())
        if let id = modified.stableID {
            BuildContext.registerListRowBackground(id, color)
        }
        return modified
    }
}
