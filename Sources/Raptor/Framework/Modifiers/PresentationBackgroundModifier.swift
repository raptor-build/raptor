//
// PresentationBackgroundModifier.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

private struct PresentationBackgroundModifier: HTMLModifier {
    func body(content: Content) -> some HTML {
        content
    }
}

public extension HTML {
    /// Sets the background used when this element participates in a presentation.
    /// - Parameter color: The color to use as the presentation background.
    /// - Returns: A modified element with the specified presentation background.
    func presentationBackground(_ color: Color) -> some HTML {
        let modified = ModifiedHTML(content: self, modifier: PresentationBackgroundModifier())
        if let id = modified.stableID {
            var context = BuildContext.current.presentations[id] ?? .init()
            context.background = .color(color)
            BuildContext.register(id, context: context)
        }
        return modified
    }

    /// Sets the background used when this element participates in a presentation.
    /// - Parameter color: The gradient to use as the presentation background.
    /// - Returns: A modified element with the specified presentation background.
    func presentationBackground(_ color: Gradient) -> some HTML {
        let modified = ModifiedHTML(content: self, modifier: PresentationBackgroundModifier())
        if let id = modified.stableID {
            var context = BuildContext.current.presentations[id] ?? .init()
            context.background = .gradient(color)
            BuildContext.register(id, context: context)
        }
        return modified
    }
}

private struct PresentationBackgroundInlineModifier: InlineContentModifier {
    func body(content: Content) -> some InlineContent {
        content
    }
}

public extension InlineContent {
    /// Sets the background used when this element participates in a presentation.
    /// - Parameter color: The color to use as the presentation background.
    /// - Returns: A modified element with the specified presentation background.
    func presentationBackground(_ color: Color) -> some InlineContent {
        let modified = ModifiedInlineContent(content: self, modifier: PresentationBackgroundInlineModifier())
        if let id = modified.stableID {
            var context = BuildContext.current.presentations[id] ?? .init()
            context.background = .color(color)
            BuildContext.register(id, context: context)
        }
        return modified
    }

    /// Sets the background used when this element participates in a presentation.
    /// - Parameter color: The gradient to use as the presentation background.
    /// - Returns: A modified element with the specified presentation background.
    func presentationBackground(_ color: Gradient) -> some InlineContent {
        let modified = ModifiedInlineContent(content: self, modifier: PresentationBackgroundInlineModifier())
        if let id = modified.stableID {
            var context = BuildContext.current.presentations[id] ?? .init()
            context.background = .gradient(color)
            BuildContext.register(id, context: context)
        }
        return modified
    }
}
