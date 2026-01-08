//
// Style+Background.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

public extension Stylable {
    /// Applies a background color from a `Color` object.
    /// - Parameter color: The specific color value to use, specified as
    /// a `Color` instance.
    /// - Returns: The current element with the updated background color.
    func background(_ color: Color) -> Self {
        self.style(.backgroundColor(color.html))
    }

    /// Applies a gradient background
    /// - Parameter gradient: The gradient to apply
    /// - Returns: The modified HTML element
    func background(_ gradient: Gradient) -> Self {
        self.style(.backgroundImage(gradient.html))
    }
}

public extension StyleConfiguration {
    /// Applies a background color from a `Color` object.
    /// - Parameters:
    ///   - color: The specific color value to use, specified as
    /// a `Color` instance.
    ///   - bounds: The bounds used when painting the background.
    /// - Returns: The current element with the updated background color.
    func background(_ color: Color, bounds: BackgroundClipBounds) -> Self {
        var modified = self
        modified.styles.append(.backgroundColor(color.html))
        modified.styles.append(bounds.styleProperty)
        return modified
    }

    /// Applies a gradient background
    /// - Parameters:
    ///   - gradient: The gradient to apply
    ///   - bounds: The bounds used when painting the background.
    /// - Returns: The modified HTML element
    func background(_ gradient: Gradient, bounds: BackgroundClipBounds) -> Self {
        var modified = self
        modified.styles.append(.backgroundImage(gradient.html))
        modified.styles.append(bounds.styleProperty)
        return modified
    }
}
