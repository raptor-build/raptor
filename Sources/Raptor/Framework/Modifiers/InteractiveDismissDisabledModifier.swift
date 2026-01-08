//
// InteractiveDismissDisabledModifier.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

private struct InteractiveDismissDisabledModifier: HTMLModifier {
    func body(content: Content) -> some HTML {
        content
    }
}

public extension HTML {
    /// Disables interactive dismissal for this presentation.
    ///
    /// Use this modifier to prevent a presented element from being dismissed
    /// through user-initiated gestures, such as swiping or tapping outside
    /// the presentation context.
    ///
    /// - Returns: A modified element that cannot be dismissed interactively.
    func interactiveDismissDisabled() -> some HTML {
        let modified = ModifiedHTML(content: self, modifier: InteractiveDismissDisabledModifier())
        if let id = modified.stableID {
            var context = BuildContext.current.presentations[id] ?? .init()
            context.isDismissible = false
            BuildContext.register(id, context: context)
        }
        return modified
    }
}

private struct InteractiveDismissDisabledInlineModifier: InlineContentModifier {
    func body(content: Content) -> some InlineContent {
        content
    }
}

public extension InlineContent {
    /// Disables interactive dismissal for this presentation.
    ///
    /// Use this modifier to prevent a presented element from being dismissed
    /// through user-initiated gestures, such as swiping or tapping outside
    /// the presentation context.
    ///
    /// - Returns: A modified element that cannot be dismissed interactively.
    func interactiveDismissDisabled() -> some InlineContent {
        let modified = ModifiedInlineContent(content: self, modifier: InteractiveDismissDisabledInlineModifier())
        if let id = modified.stableID {
            var context = BuildContext.current.presentations[id] ?? .init()
            context.isDismissible = false
            BuildContext.register(id, context: context)
        }
        return modified
    }
}
