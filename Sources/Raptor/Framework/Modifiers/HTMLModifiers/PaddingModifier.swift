//
// PaddingModifier.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

/// A modifier that applies padding to HTML elements.
private struct PaddingModifier: HTMLModifier {
    /// The amount of padding to apply.
    var padding: SpacingAmount
    /// The edges where padding should be applied.
    var edges: Edge

    /// Applies the padding modification to the provided content.
    /// - Parameter content: The HTML content to modify.
    /// - Returns: The content with padding styles or classes applied.
    func body(content: Content) -> some HTML {
        var modified = content

        switch padding {
        case .exact(let unit):
            let styles = edges.paddingStyles(.px(unit))
            modified.attributes.append(styles: styles)
        case .semantic(let amount):
            let classes = edges.classes(prefix: "p", amount: amount.rawValue)
            modified.attributes.append(classes: classes)
        default: break
        }

        return modified
    }
}

public extension HTML {
    /// Applies padding on all sides of this element. Defaults to 20 pixels.
    /// - Parameter amount: The amount of padding to apply, specified in pixels.
    /// - Returns: A copy of the current element with the new padding applied.
    func padding(_ amount: Double = 20) -> some HTML {
        modifier(PaddingModifier(padding: .exact(amount), edges: .all))
    }

    /// Applies padding on all sides of this element using adaptive sizing.
    /// - Parameter amount: The amount of padding to apply, specified as a
    /// `SpacingAmount` case.
    /// - Returns: A copy of the current element with the new padding applied.
    func padding(_ amount: SemanticSpacing) -> some HTML {
        modifier(PaddingModifier(padding: .semantic(amount), edges: .all))
    }

    /// Applies padding on selected sides of this element. Defaults to 20 pixels.
    /// - Parameters:
    ///   - edges: The edges where this padding should be applied.
    ///   - amount: The amount of padding to apply, specified in pixels.
    /// - Returns: A copy of the current element with the new padding applied.
    func padding(_ edges: Edge, _ amount: Double = 20) -> some HTML {
        modifier(PaddingModifier(padding: .exact(amount), edges: edges))
    }

    /// Applies padding on selected sides of this element using adaptive sizing.
    /// - Parameters:
    ///   - edges: The edges where this padding should be applied.
    ///   - amount: The amount of padding to apply, specified as a
    /// `SpacingAmount` case.
    /// - Returns: A copy of the current element with the new padding applied.
    func padding(_ edges: Edge, _ amount: SemanticSpacing) -> some HTML {
        modifier(PaddingModifier(padding: .semantic(amount), edges: edges))
    }
}
