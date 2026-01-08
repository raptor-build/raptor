//
// MarginModifier.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

/// A modifier that applies margins to HTML elements.
private struct MarginModifier: HTMLModifier {
    /// The margin amount to apply.
    var margin: SpacingAmount
    /// The edges where the margin should be applied.
    var edges: Edge

    /// Applies the margin styling to the content.
    /// - Parameter content: The HTML content to modify.
    /// - Returns: The content with margin styling applied.
    func body(content: Content) -> some HTML {
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

public extension HTML {
    /// Applies margins on all sides of this element. Defaults to 20 pixels.
    /// - Parameter amount: The amount of margin to apply, specified in pixels.
    /// - Returns: A copy of the current element with the new margins applied.
    func margin(_ amount: Double = 20) -> some HTML {
        modifier(MarginModifier(margin: .exact(amount), edges: .all))
    }

    /// Applies margins on all sides of this element using adaptive sizing.
    /// - Parameter amount: The amount of margin to apply, specified as a
    /// `SpacingAmount` case.
    /// - Returns: A copy of the current element with the new margins applied.
    func margin(_ amount: SemanticSpacing) -> some HTML {
        modifier(MarginModifier(margin: .semantic(amount), edges: .all))
    }

    /// Applies margins on selected sides of this element. Defaults to 20 pixels.
    /// - Parameters:
    ///   - edges: The edges where this margin should be applied.
    ///   - amount: The amount of margin to apply, specified in pixels.
    /// - Returns: A copy of the current element with the new margins applied.
    func margin(_ edges: Edge, _ amount: Double = 20) -> some HTML {
        modifier(MarginModifier(margin: .exact(amount), edges: edges))
    }

    /// Applies margins on selected sides of this element, using adaptive sizing.
    /// - Parameters:
    ///   - edges: The edges where this margin should be applied.
    ///   - amount: The amount of margin to apply, specified as a
    ///   `SpacingAmount` case.
    /// - Returns: A copy of the current element with the new margins applied.
    func margin(_ edges: Edge, _ amount: SemanticSpacing) -> some HTML {
        modifier(MarginModifier(margin: .semantic(amount), edges: edges))
    }
}
