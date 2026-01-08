//
// ScreenRelativeFrameInlineModifier.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

/// A modifier that sizes an element relative to its parent container.
private struct ScreenRelativeFrameInlineModifier: InlineContentModifier {
    /// The axes the element should fill (horizontal, vertical, or both).
    var axis: Axis

    func body(content: Content) -> some InlineContent {
        var modified = content

        if axis.contains(.horizontal) {
            modified.attributes.append(styles: .width(.dvw(100)))
        }

        if axis.contains(.vertical) {
            modified.attributes.append(styles: .height(.dvh(100)))
        }

        return modified
    }
}

public extension InlineContent {
    /// Sizes the element relative to the screen.
    /// - Parameter axis: The axes to fill (`.horizontal`, `.vertical`, or both).
    /// - Returns: A modified copy of the element with screen-relative sizing.
    func screenRelativeFrame(_ axis: Axis = .horizontal) -> some InlineContent {
        modifier(ScreenRelativeFrameInlineModifier(axis: axis))
    }

    /// Sizes and aligns the element using percentage-based dimensions relative to the screen.
    /// - Parameters:
    ///   - minWidth: Minimum width as a percentage of the screen.
    ///   - width: Exact width as a percentage of the screen.
    ///   - maxWidth: Maximum width as a percentage of the screen.
    ///   - minHeight: Minimum height as a percentage of the screen.
    ///   - height: Exact height as a percentage of the screen.
    ///   - maxHeight: Maximum height as a percentage of the screen.
    ///   - alignment: Optional alignment. When set, wraps element in a flex container.
    /// - Returns: Modified HTML with screen-relative sizing and optional alignment.
    func screenRelativeFrame(
        minWidth: Percentage? = nil,
        width: Percentage? = nil,
        maxWidth: Percentage? = nil,
        minHeight: Percentage? = nil,
        height: Percentage? = nil,
        maxHeight: Percentage? = nil,
        alignment: Alignment? = nil
    ) -> some HTML {
        var promoted = InlineHTML(self)
        promoted.attributes.append(styles: .display(.inlineBlock))

        return ScreenRelativeFrameHTML(
            content: promoted,
            minWidth: minWidth,
            width: width,
            maxWidth: maxWidth,
            minHeight: minHeight,
            height: height,
            maxHeight: maxHeight,
            alignment: alignment
        )
    }
}
