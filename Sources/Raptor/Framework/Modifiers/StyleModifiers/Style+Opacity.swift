//
// Style+Opacity.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

public extension Stylable {
    /// Adjusts the opacity of an element.
    /// - Parameter value: A value between 0% (fully transparent) and 100% (fully opaque).
    /// - Returns: A modified copy of the element with opacity applied
    func opacity(_ percentage: Percentage) -> Self {
        self.style(.opacity(percentage.value))
    }

    /// Adjusts the opacity of an element.
    /// - Parameter value: A value between 0 (fully transparent) and 1.0 (fully opaque).
    /// - Returns: A modified copy of the element with opacity applied
    func opacity(_ value: Double) -> Self {
        self.style(.opacity(value))
    }
}
