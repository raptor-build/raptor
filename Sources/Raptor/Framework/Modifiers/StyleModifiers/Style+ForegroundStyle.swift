//
// Style+ForegroundStyle.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

public extension Stylable {
    /// Applies a foreground color to the current element.
    /// - Parameter color: The style to apply, specified as a `Color` object.
    /// - Returns: The current element with the updated color applied.
    func foregroundStyle(_ color: Color) -> Self {
        self.style(.color(color.html))
    }
}
