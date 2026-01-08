//
// FullScreenOverlayModifier.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

/// Places an overlay fixed to the viewport, aligned relative to the screen.
private struct FullScreenOverlayModifier<Overlay: HTML>: HTMLModifier {
    /// Alignment relative to viewport
    let alignment: Alignment

    /// Overlay HTML content
    let overlay: Overlay

    @HTMLBuilder func body(content: Content) -> some HTML {
        content

        overlay
            .style(.position(.fixed))
            .style(.zIndex(9999))
            .style(alignment.fixedPositionRules)
    }
}

public extension HTML {
    /// Places an overlay on top of the entire screen, aligned relative to the viewport.
    /// - Parameters:
    ///   - alignment: Screen alignment. Default is `.center`.
    ///   - content: Overlay builder.
    /// - Returns: A modified copy of the element with a full-screen overlay applied.
    func fullScreenOverlay<Overlay: HTML>(
        alignment: Alignment = .center,
        @HTMLBuilder content: () -> Overlay
    ) -> some HTML {
        modifier(FullScreenOverlayModifier(alignment: alignment, overlay: content()))
    }
}

extension Alignment {
    /// CSS rules for viewport-fixed overlays.
    var fixedPositionRules: [Property] {
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
