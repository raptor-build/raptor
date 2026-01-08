//
// MarginInlineModifier.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

/// A modifier that applies margin spacing to inline elements.
private struct MarginInlineModifier: InlineContentModifier {
    /// The amount of margin to apply.
    var margin: SpacingAmount
    /// The edges where margin should be applied.
    var edges: Edge

    func body(content: Content) -> some InlineContent {
        var modified = content

        switch margin {
        case .exact(let unit):
            let styles = edges.marginStyles(.px(unit))
            modified.attributes.append(styles: styles)
        case .semantic(let amount):
            let classes = edges.classes(prefix: "m", amount: amount.rawValue)
            modified.attributes.append(classes: classes)
        default: break
        }

        return modified
    }
}

public extension InlineContent {
    /// Applies margins on all sides of this element. Defaults to 20 pixels.
    /// - Parameter amount: The amount of margin to apply, specified in pixels.
    /// - Returns: A copy of the current element with the new margins applied.
    func margin(_ amount: Double = 20) -> some InlineContent {
        modifier(MarginInlineModifier(margin: .exact(amount), edges: .all))
    }

    /// Applies margins on all sides of this element using adaptive sizing.
    /// - Parameter amount: The amount of margin to apply, specified as a
    /// `SpacingAmount` case.
    /// - Returns: A copy of the current element with the new margins applied.
    func margin(_ amount: SemanticSpacing) -> some InlineContent {
        modifier(MarginInlineModifier(margin: .semantic(amount), edges: .all))
    }

    /// Applies margins on selected sides of this element. Defaults to 20 pixels.
    /// - Parameters:
    ///   - edges: The edges where this margin should be applied.
    ///   - amount: The amount of margin to apply, specified in pixels.
    /// - Returns: A copy of the current element with the new margins applied.
    func margin(_ edges: Edge, _ amount: Double = 20) -> some InlineContent {
        modifier(MarginInlineModifier(margin: .exact(amount), edges: edges))
    }

    /// Applies margins on selected sides of this element, using adaptive sizing.
    /// - Parameters:
    ///   - edges: The edges where this margin should be applied.
    ///   - amount: The amount of margin to apply, specified as a
    ///   `SpacingAmount` case.
    /// - Returns: A copy of the current element with the new margins applied.
    func margin(_ edges: Edge, _ amount: SemanticSpacing) -> some InlineContent {
        modifier(MarginInlineModifier(margin: .semantic(amount), edges: edges))
    }
}
