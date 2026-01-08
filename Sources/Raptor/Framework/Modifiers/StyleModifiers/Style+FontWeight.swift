//
// Style+FontWeight.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

public extension Stylable {
    /// Adjusts the font weight (boldness) of this font.
    /// - Parameter weight: The new font weight.
    /// - Returns: A new instance with the updated weight.
    func fontWeight(_ weight: Font.Weight) -> Self {
        return self.style(.fontWeight(weight.html))
    }
}
