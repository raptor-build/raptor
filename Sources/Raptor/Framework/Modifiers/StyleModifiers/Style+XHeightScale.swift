//
// Style+XHeightScale.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

public extension Stylable {
    /// Sets the x-height scale factor for the font, controlling lowercase letter proportions.
    /// - Parameter scale: The scaling factor applied to the font’s x-height
    /// (e.g. `0.5` for smaller lowercase height).
    /// - Returns: A modified `StyleConfiguration` with the updated `font-size-adjust` property.
    func xHeightScale(_ scale: Double) -> Self {
        self.style(.fontSizeAdjust(scale))
    }
}
