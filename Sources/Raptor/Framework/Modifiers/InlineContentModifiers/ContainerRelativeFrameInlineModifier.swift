//
// ContainerRelativeFrameInlineModifier.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

private struct ContainerRelativeFrameInlineModifier: InlineContentModifier {
    /// A minimum width relative to the parent, expressed as a percentage.
    var minWidth: Percentage?

    /// An exact width relative to the parent, expressed as a percentage.
    var width: Percentage?

    /// A maximum width relative to the parent, expressed as a percentage.
    var maxWidth: Percentage?

    /// A minimum height relative to the parent, expressed as a percentage.
    var minHeight: Percentage?

    /// An exact height relative to the parent, expressed as a percentage.
    var height: Percentage?

    /// A maximum height relative to the parent, expressed as a percentage.
    var maxHeight: Percentage?

    func body(content: Content) -> some InlineContent {
        var dimensionAttributes = CoreAttributes()

        if let minWidth {
            dimensionAttributes.append(styles: .minWidth(.percent(minWidth.value)))
        }

        if let width {
            dimensionAttributes.append(styles: .width(.percent(width.value)))
        }

        if let maxWidth {
            dimensionAttributes.append(styles: .maxWidth(.percent(maxWidth.value)))
        }

        if let minHeight {
            dimensionAttributes.append(styles: .minHeight(.percent(minHeight.value)))
        }

        if let height {
            dimensionAttributes.append(styles: .height(.percent(height.value)))
        }

        if let maxHeight {
            dimensionAttributes.append(styles: .maxHeight(.percent(maxHeight.value)))
        }

        return content.attributes(dimensionAttributes)
    }
}

public extension InlineContent {
    /// Sizes and aligns the element using percentage-based dimensions relative to its parent.
    /// - Parameters:
    ///   - minWidth: Minimum width as a percentage of the parent.
    ///   - width: Exact width as a percentage of the parent.
    ///   - maxWidth: Maximum width as a percentage of the parent.
    ///   - minHeight: Minimum height as a percentage of the parent.
    ///   - height: Exact height as a percentage of the parent.
    ///   - maxHeight: Maximum height as a percentage of the parent.
    /// - Returns: Modified HTML with percentage-relative sizing.
    func containerRelativeFrame(
        minWidth: Percentage? = nil,
        width: Percentage? = nil,
        maxWidth: Percentage? = nil,
        minHeight: Percentage? = nil,
        height: Percentage? = nil,
        maxHeight: Percentage? = nil
    ) -> some InlineContent {
        modifier(ContainerRelativeFrameInlineModifier(
            minWidth: minWidth,
            width: width,
            maxWidth: maxWidth,
            minHeight: minHeight,
            height: height,
            maxHeight: maxHeight
        ))
    }

    /// Sizes the element relative to its container.
    /// - Parameter axis: The axes to fill (`.horizontal`, `.vertical`, or both).
    /// - Returns: A modified copy of the element with container-relative sizing.
    func containerRelativeFrame(_ axis: Axis = .horizontal) -> some InlineContent {
        var width: Percentage?
        var height: Percentage?
        if axis.contains(.horizontal) { width = 100% }
        if axis.contains(.vertical) { height = 100% }

        return modifier(ContainerRelativeFrameInlineModifier(
            width: width,
            height: height
        ))
    }
}

public extension InlineContent {
    /// Sizes and aligns the element using percentage-based dimensions relative to its parent.
    /// - Parameters:
    ///   - minWidth: Minimum width as a percentage of the parent.
    ///   - width: Exact width as a percentage of the parent.
    ///   - maxWidth: Maximum width as a percentage of the parent.
    ///   - minHeight: Minimum height as a percentage of the parent.
    ///   - height: Exact height as a percentage of the parent.
    ///   - maxHeight: Maximum height as a percentage of the parent.
    ///   - alignment: Optional alignment. When set, wraps element in a flex container.
    /// - Returns: Modified HTML with percentage-relative sizing and optional alignment.
    func containerRelativeFrame(
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

        return ContainerRelativeFrameHTML(
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

    /// Sizes the element relative to its container.
    /// - Parameter axis: The axes to fill (`.horizontal`, `.vertical`, or both).
    /// - Returns: A modified copy of the element with container-relative sizing.
    func containerRelativeFrame(_ axis: Axis = .horizontal, alignment: Alignment? = nil) -> some HTML {
        var promoted = InlineHTML(self)
        promoted.attributes.append(styles: .display(.inlineBlock))

        var width: Percentage?
        var height: Percentage?
        if axis.contains(.horizontal) { width = 100% }
        if axis.contains(.vertical) { height = 100% }

        return ContainerRelativeFrameHTML(
            content: promoted,
            width: width,
            height: height,
            alignment: alignment
        )
    }
}
