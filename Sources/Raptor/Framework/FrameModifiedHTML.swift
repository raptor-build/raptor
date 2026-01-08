//
// FrameModifiedHTML.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

/// A wrapper that applies frame constraints and alignment to HTML content.
///
/// Frame modifications allow you to control the sizing and positioning of HTML elements
/// by setting width, height, and alignment properties.
struct FrameModifiedHTML<Content: HTML>: HTML {
    /// The content and behavior of this HTML.
    var body: Never { fatalError() }

    /// The standard set of control attributes for HTML elements.
    var attributes = CoreAttributes()

    /// The HTML content to be framed.
    var content: Content

    /// The minimum width constraint.
    var minWidth: LengthUnit?

    /// The width constraint.
    var width: LengthUnit?

    /// The maximum width constraint.
    var maxWidth: LengthUnit?

    /// The minimum height constraint.
    var minHeight: LengthUnit?

    /// The height constraint.
    var height: LengthUnit?

    /// The maximum height constraint.
    var maxHeight: LengthUnit?

    /// The alignment for positioning the content within the frame.
    var alignment: Alignment?

    /// Renders the framed content as HTML markup.
    /// - Returns: The rendered HTML markup with applied frame modifications.
    func render() -> Markup {
        var dimensionAttributes = CoreAttributes()

        if alignment != nil && (minWidth != nil || width != nil || maxWidth != nil) {
            dimensionAttributes.append(classes: "frame-width")
        }

        if alignment != nil && (minHeight != nil || height != nil || maxHeight != nil) {
            dimensionAttributes.append(classes: "frame-height")
        }

        if let minWidth {
            dimensionAttributes.append(styles: .minWidth(minWidth))
        }

        if let width {
            dimensionAttributes.append(styles: .width(width))
        }

        if let maxWidth {
            if width == nil {
                // If no width has been explicitly set, allow content
                // to scale with screen sizes smaller than the max width
                // as a sensible default
                dimensionAttributes.append(styles: .width(.percent(100)))
            }
            dimensionAttributes.append(styles: .maxWidth(maxWidth))
        }

        if let minHeight {
            dimensionAttributes.append(styles: .minHeight(minHeight))
        }

        if let height {
            dimensionAttributes.append(styles: .height(height))
        }

        if let maxHeight {
            dimensionAttributes.append(styles: .maxHeight(maxHeight))
        }

        if let alignment {
            dimensionAttributes.append(styles: alignment.gridAlignmentRules)

            return Section {
                content
                    .attributes(attributes)
            }
            .attributes(dimensionAttributes)
            .render()
        } else {
            return content
                .attributes(attributes)
                .attributes(dimensionAttributes)
                .render()
        }
    }
}
