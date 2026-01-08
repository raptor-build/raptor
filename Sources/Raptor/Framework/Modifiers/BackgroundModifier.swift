//
// Background.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

private enum BackgroundStyle: Sendable {
    case color(Color)
    case gradient(Gradient)
    case material(Material)
}

/// A modifier that applies a background with optional clipping bounds.
private struct BackgroundModifier: HTMLModifier {
    var background: BackgroundStyle
    var clipBounds: BackgroundClipBounds

    func body(content: Content) -> some HTML {
        var modified = content

        switch background {
        case .color(let color):
            modified.attributes.append(styles: .backgroundColor(color.html))
        case .gradient(let gradient):
            modified.attributes.append(styles: .backgroundImage(gradient.html))
        case .material(let material):
            modified.attributes.append(classes: material.className)
        }

        if clipBounds != .border {
            modified.attributes.append(styles: clipBounds.styleProperty)
        }

        return modified
    }
}

public extension HTML {

    /// Applies a color background to the element.
    /// - Parameters:
    ///   - color: The color to use for the background.
    ///   - bounds: The bounds used when painting the background.
    /// - Returns: A modified copy of the element.
    func background(_ color: Color, bounds: BackgroundClipBounds = .border) -> some HTML {
        modifier(BackgroundModifier(background: .color(color), clipBounds: bounds))
    }

    /// Applies a material background to the element.
    /// - Parameters:
    ///   - material: The material to apply.
    ///   - bounds: The bounds used when painting the background.
    /// - Returns: A modified copy of the element.
    func background(_ material: Material, bounds: BackgroundClipBounds = .border) -> some HTML {
        modifier(BackgroundModifier(background: .material(material), clipBounds: bounds))
    }

    /// Applies a gradient background to the element.
    /// - Parameters:
    ///   - gradient: The gradient to apply.
    ///   - bounds: The bounds used when painting the background.
    /// - Returns: A modified copy of the element.
    func background(_ gradient: Gradient, bounds: BackgroundClipBounds = .border) -> some HTML {
        modifier(BackgroundModifier(background: .gradient(gradient), clipBounds: bounds))
    }
}

/// A modifier that applies a background to inline content with optional clipping bounds.
private struct BackgroundInlineModifier: InlineContentModifier {
    var background: BackgroundStyle
    var clipBounds: BackgroundClipBounds

    func body(content: Content) -> some InlineContent {
        var modified = content

        switch background {
        case .color(let color):
            modified.attributes.append(styles: .backgroundColor(color.html))
        case .gradient(let gradient):
            modified.attributes.append(styles: .backgroundImage(gradient.html))
        case .material(let material):
            modified.attributes.append(classes: material.className)
        }

        if clipBounds != .border {
            modified.attributes.append(styles: clipBounds.styleProperty)
        }

        return modified
    }
}

public extension InlineContent {

    /// Applies a color background to the inline content.
    /// - Parameters:
    ///   - color: The color to use for the background.
    ///   - bounds: The bounds used when painting the background.
    /// - Returns: Modified inline content.
    func background(_ color: Color, bounds: BackgroundClipBounds = .border) -> some InlineContent {
        modifier(BackgroundInlineModifier(background: .color(color), clipBounds: bounds))
    }

    /// Applies a material background to the inline content.
    /// - Parameters:
    ///   - material: The material to apply.
    ///   - bounds: The bounds used when painting the background.
    /// - Returns: Modified inline content.
    func background(_ material: Material, bounds: BackgroundClipBounds = .border) -> some InlineContent {
        modifier(BackgroundInlineModifier(background: .material(material), clipBounds: bounds))
    }

    /// Applies a gradient background to the inline content.
    /// - Parameters:
    ///   - gradient: The gradient to apply.
    ///   - bounds: The bounds used when painting the background.
    /// - Returns: Modified inline content.
    func background(_ gradient: Gradient, bounds: BackgroundClipBounds = .border) -> some InlineContent {
        modifier(BackgroundInlineModifier(background: .gradient(gradient), clipBounds: bounds))
    }
}
