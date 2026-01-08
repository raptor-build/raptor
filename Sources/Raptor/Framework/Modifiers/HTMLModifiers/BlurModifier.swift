//
// BlurModifier.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

/// Applies a soft, fading blur to one or more edges of a view.
private struct BlurEdgeEffectModifier: HTMLModifier {
    /// The edges on which to apply the blur effect.
    var edges: Edge

    /// The blur radius, in pixels.
    var radius: Int

    /// The size of the fading region as a percentage of the view.
    var spread: Int

    func body(content: Content) -> some HTML {
        var modified = content

        modified.attributes.append(classes: "blur-edge")
        modified.attributes.append(styles:
            .variable("blur-radius", value: "\(radius)px"),
            .variable("blur-edge-size", value: "\(spread)%")
        )

        if edges == .all {
            modified.attributes.append(classes: "blur-edge-all")
            return modified
        }

        if edges.contains(.horizontal) {
            modified.attributes.append(classes: "blur-edge-horizontal")
        }

        if edges.contains(.vertical) {
            modified.attributes.append(classes: "blur-edge-vertical")
        }

        if edges.contains(.top) {
            modified.attributes.append(classes: "blur-edge-top")
        }

        if edges.contains(.bottom) {
            modified.attributes.append(classes: "blur-edge-bottom")
        }

        if edges.contains(.leading) {
            modified.attributes.append(classes: "blur-edge-leading")
        }

        if edges.contains(.trailing) {
            modified.attributes.append(classes: "blur-edge-trailing")
        }

        return modified
    }
}

public extension HTML {
    /// Applies a soft fading blur to the edges of this view.
    /// - Parameters:
    ///   - edges: The edges on which to apply the blur effect.
    ///   - radius: The blur radius in pixels. Larger values produce a softer blur.
    ///   - spread: The size of the fading region as a percentage of the view.
    func blurEdgeEffect(
        _ edges: Edge = .all,
        radius: Int = 20,
        spread: Int = 20
    ) -> some HTML {
        modifier(BlurEdgeEffectModifier(edges: edges, radius: radius, spread: spread))
    }
}
