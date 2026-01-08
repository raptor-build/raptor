//
// Style+Font.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

public extension Stylable {
    /// Adjusts the font of this text.
    /// - Parameter font: The font configuration to apply.
    /// - Returns: A new instance with the updated font.
    func font(_ font: Font) -> Self {
        BuildContext.register(font)
        return style(fontStyles(font))
    }
}

/// Converts font properties to CSS inline styles.
/// - Parameter font: The font configuration to convert.
/// - Returns: An array of inline styles representing the font properties.
private func fontStyles(_ font: Font) -> [Property] {
    var styles = [Property]()

    if let weight = font.weight {
        styles.append(.fontWeight(weight.html))
    }

    if let name = font.name, !name.isEmpty {
        styles.append(.fontFamily(.named(name)))
    }

    if let size = font.size {
        styles.append(.fontSize(size.lengthUnit))
    }

    return styles
}
