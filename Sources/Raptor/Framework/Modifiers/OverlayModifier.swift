//
// OverlayModifier.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

/// Places an overlay on top of the element, aligned relative to the element’s bounds.
private struct OverlayModifier<Overlay: HTML>: HTMLModifier {
    /// Alignment for the overlay inside the element
    let alignment: Alignment

    /// The overlay HTML content
    let overlay: Overlay

    func body(content: Content) -> some HTML {
        Section {
            content
                .style(.position(.relative))

            overlay
                .style(.position(.absolute))
                .style(alignment.absolutePositioningRules)
        }
        // Ensure overlay is layered above content
        .style(.position(.relative))
        .style(.display(.inlineBlock))
    }
}

public extension HTML {
    /// Places an overlay on top of this element, aligned relative to the element’s bounds.
    /// - Parameters:
    ///   - alignment: Alignment inside the element. Default is `.center`.
    ///   - content: The overlay builder.
    /// - Returns: A modified copy of the element with an overlay applied.
    func overlay<Overlay: HTML>(
        alignment: Alignment = .center,
        @HTMLBuilder content: () -> Overlay
    ) -> some HTML {
        modifier(OverlayModifier(alignment: alignment, overlay: content()))
    }
}

extension Alignment {
    /// Absolute-positioning CSS rules for overlays.
    var absolutePositioningRules: [Property] {
        var rules: [Property] = []

        switch vertical {
        case .top: rules.append(.top(.px(0)))
        case .center: rules.append(.top(.percent(50)))
        case .bottom: rules.append(.bottom(.px(0)))
        }

        switch horizontal {
        case .leading: rules.append(.left(.px(0)))
        case .center: rules.append(.left(.percent(50)))
        case .trailing: rules.append(.right(.px(0)))
        }

        // Center alignment needs translate(-50%, -50%)
        if horizontal == .center && vertical == .center {
            rules.append(.transform(.translate(x: .percent(-50), y: .percent(50))))
        } else if horizontal == .center {
            rules.append(.transform(.translate(x: .percent(-50))))
        } else if vertical == .center {
            rules.append(.transform(.translate(y: .percent(50))))
        }

        return rules
    }
}
