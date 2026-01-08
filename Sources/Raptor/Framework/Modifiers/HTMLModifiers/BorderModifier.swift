//
// BorderModifier.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

/// A modifier that applies borders to HTML elements.
struct BorderModifier: HTMLModifier {
    var color: Color
    var width: Double
    var style: StrokeStyle
    var edges: Edge

    /// Applies border styles to the content.
    func body(content: Content) -> some HTML {
        var modified = content
        let styles = Self.styles(color: color, width: width, style: style, edges: edges)
        modified.attributes.append(styles: styles)
        return modified
    }

    /// Generates CSS border styles for the specified parameters.
    /// - Parameters:
    ///   - color: The border color
    ///   - width: The border width in pixels
    ///   - style: The border style
    ///   - edges: The edges to apply borders to
    /// - Returns: An array of inline styles
    static func styles(
        color: Color,
        width: Double,
        style: StrokeStyle,
        edges: Edge
    ) -> [Property] {
        var styles = [Property]()

        if edges.contains(.all) {
            styles.append(.border(.init(color.html, width: width, style: style)))
        } else {
            if edges.contains(.leading) {
                styles.append(.borderLeft(.init(color.html, width: width, style: style)))
            }
            if edges.contains(.trailing) {
                styles.append(.borderRight(.init(color.html, width: width, style: style)))
            }
            if edges.contains(.top) {
                styles.append(.borderTop(.init(color.html, width: width, style: style)))
            }
            if edges.contains(.bottom) {
                styles.append(.borderBottom(.init(color.html, width: width, style: style)))
            }
        }

        return styles
    }
}

public extension HTML {
    /// Adds a border to this element.
    /// - Parameters:
    ///   - color: The color of the border
    ///   - width: The width in pixels
    ///   - style: The border style
    ///   - edges: Which edges should have borders
    /// - Returns: A modified element with the border applied
    func border(
        _ color: Color,
        width: Double = 1,
        style: StrokeStyle = .solid,
        edges: Edge = .all
    ) -> some HTML {
        modifier(BorderModifier(color: color, width: width, style: style, edges: edges))
    }
}
