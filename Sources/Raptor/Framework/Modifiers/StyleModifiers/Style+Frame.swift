//
// Style+Frame.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

public extension Stylable {
    /// Creates a specific frame for this element, either using exact values or
    /// using minimum/maximum ranges.
    /// - Parameters:
    ///   - minWidth: The minimum width in pixels
    ///   - width: The exact width in pixels
    ///   - maxWidth: The maximum width in pixels
    ///   - minHeight: The minimum height in pixels
    ///   - height: The exact height in pixels
    ///   - maxHeight: The maximum height in pixels
    /// - Returns: The modified copy of the element with frame constraints applied
    func frame(
        minWidth: Int? = nil,
        width: Int? = nil,
        maxWidth: Int? = nil,
        minHeight: Int? = nil,
        height: Int? = nil,
        maxHeight: Int? = nil
    ) -> Self {
        let dimensionStyles = FrameInlineModifier.styles(
            minWidth: minWidth,
            width: width,
            maxWidth: maxWidth,
            minHeight: minHeight,
            height: height,
            maxHeight: maxHeight)
        return self.style(dimensionStyles)
    }
}
