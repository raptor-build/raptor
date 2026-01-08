//
// CornerRadiusInlineModifier.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

/// A modifier that applies corner radius styling to HTML elements.
struct CornerRadiusInlineModifier: InlineContentModifier {
    /// The corners to round.
    var edges: DiagonalEdge
    /// The radius length value.
    var radius: Int
    /// The corner radius style.
    var style: CornerStyle

    func body(content: Content) -> some InlineContent {
        var modified = content
        let styles = CornerRadiusModifier.styles(edges: edges, radius: radius, style: style)
        modified.attributes.append(styles: styles)
        return modified
    }
}

public extension InlineContent {
    /// Rounds all edges of this object by some value specified as a string.
    /// - Parameter amount: An integer specifying a pixel amount to round corners with
    /// - Returns: A modified copy of the element with corner radius applied
    func cornerRadius(_ amount: Int) -> some InlineContent {
        modifier(CornerRadiusInlineModifier(edges: .all, radius: amount, style: .round))
    }

    /// Rounds all edges of this object by some value specified as a string.
    /// - Parameters:
    ///   - amount: An integer specifying a pixel amount to round corners with
    ///   - style: The corner style. Defaults to `.round`
    /// - Returns: A modified copy of the element with corner radius applied
    /// - Warning: This modifier relies on a feature with limited browser support
    /// and is best used as a progressive enhancement.
    func cornerRadius(_ amount: Int, style: CornerStyle) -> some InlineContent {
        modifier(CornerRadiusInlineModifier(edges: .all, radius: amount, style: style))
    }

    /// Rounds selected edges of this object by some number of pixels.
    /// - Parameters:
    ///   - edges: Which corners should be rounded
    ///   - amount: An integer specifying a pixel amount to round corners with
    /// - Returns: A modified copy of the element with corner radius applied
    func cornerRadius(_ edges: DiagonalEdge, _ amount: Int) -> some InlineContent {
        modifier(CornerRadiusInlineModifier(edges: edges, radius: amount, style: .round))
    }

    /// Rounds selected edges of this object by some number of pixels.
    /// - Parameters:
    ///   - edges: Which corners should be rounded
    ///   - amount: An integer specifying a pixel amount to round corners with
    ///   - style: The corner style. Defaults to `.round`
    /// - Returns: A modified copy of the element with corner radius applied
    /// - Warning: This modifier relies on a feature with limited browser support
    /// and is best used as a progressive enhancement.
    func cornerRadius(_ edges: DiagonalEdge, _ amount: Int, style: CornerStyle) -> some InlineContent {
        modifier(CornerRadiusInlineModifier(edges: edges, radius: amount, style: style))
    }
}
