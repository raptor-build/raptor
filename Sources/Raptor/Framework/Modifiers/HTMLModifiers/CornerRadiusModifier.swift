//
// CornerRadiusModifier.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

/// A modifier that applies corner radius styling to HTML elements.
struct CornerRadiusModifier: HTMLModifier {
    /// The corners to round.
    var edges: DiagonalEdge
    /// The radius length value.
    var radius: Int
    /// The corner radius style.
    var style: CornerStyle

    func body(content: Content) -> some HTML {
        var modified = content
        let styles = Self.styles(edges: edges, radius: radius, style: style)
        modified.attributes.append(styles: styles)
        return modified
    }

    /// Generates CSS border-radius styles for the specified edges and length.
    /// - Parameters:
    ///   - edges: The corners to round
    ///   - radius: The radius value
    ///   - style: The corner radius style
    /// - Returns: An array of inline styles for border radius
    static func styles(edges: DiagonalEdge, radius: Int, style: CornerStyle = .round) -> [Property] {
        var styles = [Property]()

        styles.append(.cornerShape(style))

        if edges.contains(.all) {
            styles.append(.borderRadius(.px(radius)))
            return styles
        }

        if edges.contains(.topLeading) {
            styles.append(.borderTopLeftRadius(.px(radius)))
        }

        if edges.contains(.topTrailing) {
            styles.append(.borderTopRightRadius(.px(radius)))
        }

        if edges.contains(.bottomLeading) {
            styles.append(.borderBottomLeftRadius(.px(radius)))
        }

        if edges.contains(.bottomTrailing) {
            styles.append(.borderBottomRightRadius(.px(radius)))
        }

        return styles
    }
}

public extension HTML {
    /// Rounds all edges of this object by some value specified as a string.
    /// - Parameter amount: An integer specifying a pixel amount to round corners with
    /// - Returns: A modified copy of the element with corner radius applied
    func cornerRadius(_ amount: Int) -> some HTML {
        modifier(CornerRadiusModifier(edges: .all, radius: amount, style: .round))
    }

    /// Rounds all edges of this object by some value specified as a string.
    /// - Parameters:
    ///   - amount: An integer specifying a pixel amount to round corners with
    ///   - style: The corner style. Defaults to `.round`
    /// - Returns: A modified copy of the element with corner radius applied
    /// - Warning: This modifier relies on a feature with limited browser support
    /// and is best used as a progressive enhancement.
    func cornerRadius(_ amount: Int, style: CornerStyle) -> some HTML {
        modifier(CornerRadiusModifier(edges: .all, radius: amount, style: style))
    }

    /// Rounds selected edges of this object by some number of pixels.
    /// - Parameters:
    ///   - edges: Which corners should be rounded
    ///   - amount: An integer specifying a pixel amount to round corners with
    /// - Returns: A modified copy of the element with corner radius applied
    func cornerRadius(_ edges: DiagonalEdge, _ amount: Int) -> some HTML {
        modifier(CornerRadiusModifier(edges: edges, radius: amount, style: .round))
    }

    /// Rounds selected edges of this object by some number of pixels.
    /// - Parameters:
    ///   - edges: Which corners should be rounded
    ///   - amount: An integer specifying a pixel amount to round corners with
    ///   - style: The corner style. Defaults to `.round`
    /// - Returns: A modified copy of the element with corner radius applied
    /// - Warning: This modifier relies on a feature with limited browser support
    /// and is best used as a progressive enhancement.
    func cornerRadius(_ edges: DiagonalEdge, _ amount: Int, style: CornerStyle) -> some HTML {
        modifier(CornerRadiusModifier(edges: edges, radius: amount, style: style))
    }
}
