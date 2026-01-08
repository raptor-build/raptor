//
// FontDesignModifier.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

/// A typographic design variant applied to a font.
public enum FontDesign: Sendable, Hashable {
    /// The default proportional font design.
    case standard

    /// A monospaced font design where all glyphs have equal width.
    case monospaced

    var family: FontFamily {
        switch self {
        case .standard: .inherit
        case .monospaced: .generic(.monospace)
        }
    }
}

private struct FontDesignModifier: HTMLModifier {
    var design: FontDesign
    func body(content: Content) -> some HTML {
        var modified = content
        modified.attributes.append(styles: .fontFamily(design.family))
        return modified
    }
}

public extension HTML {
    /// Applies a font design variant to this element.
    /// - Parameter design: The font design to apply, such as `.monospaced`.
    /// - Returns: An element that renders using the specified font design.
    func fontDesign(_ design: FontDesign) -> some HTML {
        modifier(FontDesignModifier(design: design))
    }
}

private struct FontDesignInlineModifier: InlineContentModifier {
    var design: FontDesign
    func body(content: Content) -> some InlineContent {
        var modified = content
        modified.attributes.append(styles: .fontFamily(design.family))
        return modified
    }
}

public extension InlineContent {
    /// Applies a font design variant to this element.
    /// - Parameter design: The font design to apply, such as `.monospaced`.
    /// - Returns: An element that renders using the specified font design.
    func fontDesign(_ design: FontDesign) -> some InlineContent {
        modifier(FontDesignInlineModifier(design: design))
    }
}
