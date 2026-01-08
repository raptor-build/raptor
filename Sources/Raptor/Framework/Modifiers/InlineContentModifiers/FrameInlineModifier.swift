//
// FrameInlineModifier.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

/// A modifier that applies frame constraints to inline elements.
///
/// Use this modifier to set width and height constraints on inline elements,
/// including minimum, maximum, and exact dimensions.
struct FrameInlineModifier: InlineContentModifier {
    /// The minimum width constraint.
    var minWidth: Int?
    /// The width constraint.
    var width: Int?
    /// The maximum width constraint.
    var maxWidth: Int?
    /// The minimum height constraint.
    var minHeight: Int?
    /// The height constraint.
    var height: Int?
    /// The maximum height constraint.
    var maxHeight: Int?

    /// Applies frame constraints to the provided content.
    /// - Parameter content: The inline element to modify.
    /// - Returns: The modified inline element with frame constraints applied.
    func body(content: Content) -> some InlineContent {
        var modified = content
        let styles = Self.styles(
            minWidth: minWidth,
            width: width,
            maxWidth: maxWidth,
            minHeight: minHeight,
            height: height,
            maxHeight: maxHeight)
        modified.attributes.append(styles: styles)
        return modified
    }

    /// Creates CSS styles for the specified frame constraints.
    /// - Parameters:
    ///   - minWidth: The minimum width constraint.
    ///   - width: The width constraint.
    ///   - maxWidth: The maximum width constraint.
    ///   - minHeight: The minimum height constraint.
    ///   - height: The height constraint.
    ///   - maxHeight: The maximum height constraint.
    /// - Returns: An array of inline styles representing the frame constraints.
    nonisolated static func styles(
        minWidth: Int? = nil,
        width: Int? = nil,
        maxWidth: Int? = nil,
        minHeight: Int? = nil,
        height: Int? = nil,
        maxHeight: Int? = nil
    ) -> [Property] {
        var dimensions = [Property]()

        if let minWidth {
            dimensions.append(.minWidth(.px(minWidth)))
        }

        if let width {
            dimensions.append(.width(.px(width)))
        }

        if let maxWidth {
            dimensions.append(.maxWidth(.px(maxWidth)))
        }

        if let minHeight {
            dimensions.append(.minHeight(.px(minHeight)))
        }

        if let height {
            dimensions.append(.height(.px(height)))
        }

        if let maxHeight {
            dimensions.append(.maxHeight(.px(maxHeight)))
        }

        return dimensions
    }
}

public extension InlineContent {
    /// Creates a specific frame for this element, either using exact pixel values or
    /// using minimum/maximum pixel ranges.
    /// - Parameters:
    ///   - minWidth: A minimum width for this element
    ///   - width: An exact width for this element
    ///   - maxWidth: A maximum width for this element
    ///   - minHeight: A minimum height for this element
    ///   - height: An exact height for this element
    ///   - maxHeight: A maximum height for this element
    /// - Returns: A modified copy of the element with frame constraints applied
    func frame(
        minWidth: Int? = nil,
        width: Int? = nil,
        maxWidth: Int? = nil,
        minHeight: Int? = nil,
        height: Int? = nil,
        maxHeight: Int? = nil
    ) -> some InlineContent {
        modifier(FrameInlineModifier(
            minWidth: minWidth,
            width: width,
            maxWidth: maxWidth,
            minHeight: minHeight,
            height: height,
            maxHeight: maxHeight))
    }

    /// Creates a specific frame for this element, either using exact pixel values or
    /// using minimum/maximum pixel ranges.
    /// - Parameters:
    ///   - minWidth: A minimum width for this element
    ///   - width: An exact width for this element
    ///   - maxWidth: A maximum width for this element
    ///   - minHeight: A minimum height for this element
    ///   - height: An exact height for this element
    ///   - maxHeight: A maximum height for this element
    /// - Returns: A modified copy of the element with frame constraints applied
    func frame(
        minWidth: Int? = nil,
        width: Int? = nil,
        maxWidth: Int? = nil,
        minHeight: Int? = nil,
        height: Int? = nil,
        maxHeight: Int? = nil,
        alignment: Alignment? = nil
    ) -> some HTML {
        ModifiedHTML(content: InlineHTML(self), modifier: FrameModifier(
            minWidth: minWidth.map { .px($0) },
            width: width.map { .px($0) },
            maxWidth: maxWidth.map { .px($0) },
            minHeight: minHeight.map { .px($0) },
            height: height.map { .px($0) },
            maxHeight: maxHeight.map { .px($0) },
            alignment: alignment))
    }
}
