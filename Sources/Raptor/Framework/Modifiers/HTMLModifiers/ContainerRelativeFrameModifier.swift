//
// ContainerRelativeFrameModifier.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

/// A modifier that sizes and aligns an element using percentage–relative
/// dimensions instead of pixel-based dimensions.
struct ContainerRelativeFrameHTML<Content: HTML>: HTML {
    var body: Never { fatalError() }

    /// The standard set of control attributes for HTML elements.
    var attributes: CoreAttributes = .init()

    /// The HTML content to be framed.
    var content: Content

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

    /// How to align the element inside its relative frame.
    /// When `nil`, sizing is applied directly to the element.
    var alignment: Alignment?

    func render() -> Markup {
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

        if let alignment {
            return Section {
                content
                    .attributes(attributes)
            }
            .attributes(dimensionAttributes)
            .style(alignment.gridAlignmentRules)
            .class("container-relative")
            .render()
        }

        return content
            .attributes(attributes)
            .style(.display(.block))
            .attributes(dimensionAttributes)
            .render()
    }
}

public extension HTML {
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
        ContainerRelativeFrameHTML(
            content: self,
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

public extension HTML {
    /// Sizes the element relative to its container.
    /// - Parameter axis: The axes to fill (`.horizontal`, `.vertical`, or both).
    /// - Returns: A modified copy of the element with container-relative sizing.
    func containerRelativeFrame(_ axis: Axis = .horizontal, alignment: Alignment? = nil) -> some HTML {
        var width: Percentage?
        var height: Percentage?
        if axis.contains(.horizontal) { width = 100% }
        if axis.contains(.vertical) { height = 100% }

        return ContainerRelativeFrameHTML(
            content: self,
            width: width,
            height: height,
            alignment: alignment
        )
    }
}
