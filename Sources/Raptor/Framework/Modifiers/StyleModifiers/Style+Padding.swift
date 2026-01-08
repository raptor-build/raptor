//
// Style+Padding.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

public extension Stylable {
    /// Applies padding on selected sides of this element. Defaults to 20 pixels.
    /// - Parameter amount: The amount of padding to apply, specified in pixels.
    /// - Returns: A copy of the current element with the new padding applied.
    func padding(_ amount: Int = 20) -> Self {
        let styles = Edge.all.paddingStyles(.px(amount))
        return self.style(styles)
    }

    /// Applies padding on selected sides of this element. Defaults to 20 pixels.
    /// - Parameters:
    ///   - edges: The edges where this padding should be applied.
    ///   - amount: The amount of padding to apply, specified in pixels.
    /// - Returns: A copy of the current element with the new padding applied.
    func padding(_ edges: Edge, _ amount: Int = 20) -> Self {
        let styles = edges.paddingStyles(.px(amount))
        return self.style(styles)
    }
}
