//
// Style+Margin.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

public extension Stylable {
    /// Applies margins on selected sides of this element. Defaults to 20 pixels.
    /// - Parameter amount: The amount of margin to apply, specified in pixels.
    /// - Returns: A copy of the current element with the new margins applied.
    func margin(_ amount: Int = 20) -> Self {
        let styles = Edge.all.marginStyles(.px(amount))
        return self.style(styles)
    }

    /// Applies margins on selected sides of this element. Defaults to 20 pixels.
    /// - Parameters:
    ///   - edges: The edges where this margin should be applied.
    ///   - amount: The amount of margin to apply, specified in pixels.
    /// - Returns: A copy of the current element with the new margins applied.
    func margin(_ edges: Edge, _ amount: Int = 20) -> Self {
        let styles = edges.marginStyles(.px(amount))
        return self.style(styles)
    }
}
