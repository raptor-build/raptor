//
// Style+CornerRadius.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

public extension Stylable {
    /// Rounds all edges of this object by some number of pixels.
    /// - Parameter amount: An integer specifying a pixel amount to round corners with
    /// - Returns: A modified copy of the element with corner radius applied
    func cornerRadius(_ amount: Int) -> Self {
        let styles = CornerRadiusModifier.styles(edges: .all, radius: amount)
        return self.style(styles)
    }

    /// Rounds selected edges of this object by some value specified as a string.
    /// - Parameters:
    ///   - edges: Which corners should be rounded
    ///   - amount: An integer specifying a pixel amount to round corners with
    /// - Returns: A modified copy of the element with corner radius applied
    func cornerRadius(_ edges: DiagonalEdge, _ amount: Int) -> Self {
        let styles = CornerRadiusModifier.styles(edges: edges, radius: amount)
        return self.style(styles)
    }
}
