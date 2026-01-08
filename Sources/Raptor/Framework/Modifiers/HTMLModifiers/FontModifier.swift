//
// FontModifier.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

/// A modifier that applies font styling to HTML content.
 struct FontModifier: HTMLModifier {
    var font: Font

    /// Creates modified HTML content with the specified font styling.
    func body(content: Content) -> some HTML {
        BuildContext.register(font)
        var modified = content
        let attributes = FontModifier.attributes(for: font, includeStyle: true)
        modified.attributes.merge(attributes)
        return modified
    }

    /// Generates CSS attributes for the specified font configuration.
    /// - Parameters:
    ///   - font: The font to generate attributes for.
    ///   - includeStyle: Whether to include style classes in the output.
    /// - Returns: Core attributes containing the font styling.
    static func attributes(for font: Font, includeStyle: Bool) -> CoreAttributes {
        var attributes = CoreAttributes()

        if let name = font.name, !name.isEmpty {
            attributes.append(styles: .fontFamily(.named(name)))
        }

        if let weight = font.weight {
            attributes.append(styles: .fontWeight(weight.html))
        }

        if let size = font.size {
            attributes.append(styles: .fontSize(size.lengthUnit))
        }

        if includeStyle, let style = font.style, let sizeClass = style.sizeClass {
            attributes.append(classes: sizeClass)
        }

        return attributes
    }
}

public extension HTML {
    /// Adjusts the font of this text.
    /// - Parameter font: The font configuration to apply.
    /// - Returns: A new instance with the updated font.
    func font(_ font: Font) -> some HTML {
        modifier(FontModifier(font: font))
    }
}
